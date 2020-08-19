import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WaterBodyApi {
  static const url =
      'https://app.fw.ky.gov/fishingboatingwebapi/api/waterbody/all';

  static const Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<List<WaterBody>> getAllWaterBodies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getInt('waterBodyApiDate') == null) {
      await prefs.setInt('waterBodyApiDate', 0);
    }

    DateTime cache =
        DateTime.fromMillisecondsSinceEpoch(prefs.getInt('waterBodyApiDate'));

    bool useCache;
    if (cache.add(Duration(days: 1)).isBefore(DateTime.now())) {
      useCache = false;
    } else {
      useCache = true;
    }

    var bodiesJson;
    if (useCache == false) {
      var body = json.encode({});

      var response = await http.post(url, body: body, headers: headers);

      if (response.statusCode != 200) return List<WaterBody>();

      await prefs.setInt(
          'waterBodyApiDate', DateTime.now().millisecondsSinceEpoch);

      await prefs.setString('waterBodyApi', response.body);

      bodiesJson = json.decode(response.body);
    } else {
      bodiesJson = json.decode(prefs.getString('waterBodyApi'));
    }

    List<WaterBody> waterBodies = List<WaterBody>();
    for (var bodyJson in bodiesJson['Result']) {
      WaterBody body = WaterBody(
        id: bodyJson['waterbodyDetails']['waterBody_Id'],
        name: bodyJson['waterbodyDetails']['name'],
        desc: bodyJson['waterbodyDetails']['description'],
        notes: bodyJson['waterbodyDetails']['notes'],
        size: bodyJson['waterbodyDetails']['waterbodySize'],
        typeName: bodyJson['waterbodyDetails']['waterbodyTypeName'],
        type: bodyJson['waterbodyDetails']['waterbodyType'],
        modified: bodyJson['waterbodyDetails']['modified'],
        finsFlag: bodyJson['waterbodyDetails']['finsFlag'],
        lat: bodyJson['waterbodyDetails']['latitude'],
        lng: bodyJson['waterbodyDetails']['longitude'],
        imgUrl: bodyJson['imageDetails'][0]['imageLocation'],
        imgDesc: bodyJson['imageDetails'][0]['imageDescription'],
      );

      waterBodies.add(body);
    }

    return waterBodies;
  }
}

class WaterBody {
  final int id;
  final String name;
  final String desc;
  final String notes;
  final String size;
  final String typeName;
  final String type;
  final String modified;
  final bool finsFlag;
  final double lat;
  final double lng;
  final String imgUrl;
  final String imgDesc;

  WaterBody(
      {this.id,
      this.name,
      this.desc,
      this.notes,
      this.size,
      this.typeName,
      this.type,
      this.modified,
      this.finsFlag,
      this.lat,
      this.lng,
      this.imgUrl,
      this.imgDesc});
}
