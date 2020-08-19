import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WaterAccessApi {
  static const String url =
      'https://app.fw.ky.gov/fishingboatingwebapi/api/accessSites/details';

  static const Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<List<AccessSite>> getAllAcessSites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getInt('waterAccessApiDate') == null) {
      await prefs.setInt('waterAccessApiDate', 0);
    }

    DateTime cache =
        DateTime.fromMillisecondsSinceEpoch(prefs.getInt('waterAccessApiDate'));

    bool useCache;
    if (cache.add(Duration(days: 1)).isBefore(DateTime.now())) {
      useCache = false;
    } else {
      useCache = true;
    }

    var sitesJson;

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

      if (response.statusCode != 200) return List<AccessSite>();

      await prefs.setInt(
          'waterAccessApiDate', DateTime.now().millisecondsSinceEpoch);

      await prefs.setString('waterAccessApi', response.body);

      sitesJson = json.decode(response.body);
    } else {
      sitesJson = json.decode(prefs.getString('waterAccessApi'));
    }

    List<AccessSite> sites = List<AccessSite>();
    for (var siteJson in sitesJson['Result']) {
      AccessSite site = AccessSite(
        id: siteJson['accessSiteDetails']['accessSite_ID'],
        type: siteJson['accessSiteDetails']['accessType'],
        typeCode: siteJson['accessSiteDetails']['accessTypeCode'],
        accessSurface: siteJson['accessSiteDetails']['accessSurface'],
        modified: siteJson['accessSiteDetails']['Modified'],
        name: siteJson['accessSiteDetails']['accessSiteName'],
        fee: siteJson['accessSiteDetails']['accessFee'],
        notes: siteJson['accessSiteDetails']['accessNotes'],
        lat: siteJson['accessSiteDetails']['latitude'],
        lng: siteJson['accessSiteDetails']['longitude'],
        county: siteJson['accessSiteDetails']['accessCounty'],
        shoreLine: siteJson['accessSiteDetails']['shoreLine'],
        boatRamp: siteJson['accessSiteDetails']['boatRamp'],
        restrooms: siteJson['accessSiteDetails']['restrooms'],
        waterBodyId: siteJson['accessSiteDetails']['waterBody_ID'],
        handicapRestrooms: siteJson['accessSiteDetails']['handicapRestrooms'],
        handicapParking: siteJson['accessSiteDetails']['handicapParking'],
        handicapPier: siteJson['accessSiteDetails']['handicapPier'],
        handicapRamp: siteJson['accessSiteDetails']['handicapRamp'],
        kdfwrFlag: siteJson['accessSiteDetails']['kdfwrFlag'],
        imgUrl: siteJson['imageDetails'][0]['imageLocation'],
        imgDesc: siteJson['imageDetails'][0]['imageDescription'],
        capacity: siteJson['accessSiteDetails']['capacity'],
        waterBodyName: siteJson['waterbodyDetails'][0]['name'],
      );

      sites.insert(0, site);
    }

    return sites;
  }
}

class AccessSite {
  final int id;
  final String type;
  final String typeCode;
  final String capacity;
  final String accessSurface;
  final String modified;
  final String name;
  final bool fee;
  final String notes;
  final double lat;
  final double lng;
  final String county;
  final String shoreLine;
  final String boatRamp;
  final String restrooms;
  final int waterBodyId;
  final String handicapRestrooms;
  final String handicapParking;
  final String handicapPier;
  final String handicapRamp;
  final bool kdfwrFlag;
  final int imgId;
  final String imgUrl;
  final String imgDesc;
  final String waterBodyName;

  AccessSite({
    this.id,
    this.type,
    this.typeCode,
    this.capacity,
    this.accessSurface,
    this.modified,
    this.name,
    this.fee,
    this.notes,
    this.lat,
    this.lng,
    this.county,
    this.shoreLine,
    this.boatRamp,
    this.restrooms,
    this.waterBodyId,
    this.handicapRestrooms,
    this.handicapParking,
    this.handicapPier,
    this.handicapRamp,
    this.kdfwrFlag,
    this.imgId,
    this.imgUrl,
    this.imgDesc,
    this.waterBodyName,
  });
}
