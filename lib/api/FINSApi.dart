import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FINSApi {
  static const String url =
      'https://app.fw.ky.gov/fishingboatingwebapi/api/waterbody/fins';

  static const Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<List<FIN>> getAllFINS() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getInt('finsApiDate') == null) {
      await prefs.setInt('finsApiDate', 0);
    }

    DateTime cache =
        DateTime.fromMillisecondsSinceEpoch(prefs.getInt('finsApiDate'));

    bool useCache;
    if (cache.add(Duration(days: 1)).isBefore(DateTime.now())) {
      useCache = false;
    } else {
      useCache = true;
    }

    var finsJson;

    if (useCache == false) {
      var body = json.encode({
        "northEastLat": 102.81401063830785,
        "northEastLng": -44.617968556271705,
        "southWestLat": -17.074970707553526,
        "southWestLng": -132.61403304680803,
        "userLat": 38.141783771370896,
        "userLng": -84.85246857970064
      });

      var response = await http.post(url, body: body, headers: headers);

      if (response.statusCode != 200) return List<FIN>();

      await prefs.setInt('finsApiDate', DateTime.now().millisecondsSinceEpoch);

      await prefs.setString('finsApi', response.body);

      finsJson = json.decode(response.body);
    } else {
      finsJson = json.decode(prefs.getString('finsApi'));
    }

    List<FIN> fins = List<FIN>();
    for (var finJson in finsJson['Result']) {
      FIN fin = FIN(
        id: finJson['waterbodyDetails']['waterBody_Id'],
        name: finJson['waterbodyDetails']['name'],
        desc: finJson['waterbodyDetails']['description'],
        notes: finJson['waterbodyDetails']['notes'],
        size: finJson['waterbodyDetails']['waterbodySize'],
        typeName: finJson['waterbodyDetails']['waterbodyTypeName'],
        type: finJson['waterbodyDetails']['waterbodyType'],
        modified: finJson['waterbodyDetails']['modified'],
        finsFlag: finJson['waterbodyDetails']['finsFlag'],
        lat: finJson['waterbodyDetails']['latitude'],
        lng: finJson['waterbodyDetails']['longitude'],
        imgId: finJson['imageDetails'][0]['image_ID'],
        imgUrl: finJson['imageDetails'][0]['imageLocation'],
        imgDesc: finJson['imageDetails'][0]['imageDescription'],
      );

      fins.insert(0, fin);
    }

    return fins;
  }
}

class FIN {
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
  final int imgId;
  final String imgUrl;
  final String imgDesc;

  FIN(
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
      this.imgId,
      this.imgUrl,
      this.imgDesc});
}
