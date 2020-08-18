import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Map<MarkerId, Marker> markers =
      <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

  void _add(String markerIdVal, String snippet, lat, lng) {
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(
          title: markerIdVal, snippet: snippet, onTap: () => print('Tapped')),
      onTap: () {
        print(markerId);
      },
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

  _getAllAccessSites() async {
    const String url =
        'https://app.fw.ky.gov/fishingboatingwebapi/api/accessSites/details';

    var body = json.encode({
      "northEastLat": 38.81088413602677,
      "northEastLng": -83.85073424186862,
      "southWestLat": 34.95122227420873,
      "southWestLng": -86.17673735140696,
      "userLat": 38.141783771370896,
      "userLng": -84.85246857970064
    });

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    var response = await http.post(url, body: body, headers: headers);

    final responseJson = json.decode(response.body);

    //print(responseJson['Result']);

    for (var site in responseJson['Result']) {
      _add(site['accessSiteDetails']['accessSiteName'], site['accessSiteDetails']['accessType'], site['accessSiteDetails']['latitude'], site['accessSiteDetails']['longitude']);
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllAccessSites();
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(38.34306, -84.03564),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: Set<Marker>.of(markers.values),
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
