import 'dart:async';

import 'package:FWW/api/WaterAccessApi.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Widget loadingWidget = CircularProgressIndicator();

  _onMapCreated(GoogleMapController controller) async {
    WaterAccessApi api = WaterAccessApi();

    List<AccessSite> sites = await api.getAllAcessSites();

    markers.clear();
    for (AccessSite site in sites) {
      final MarkerId markerId = MarkerId(site.name);
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(site.lat, site.lng),
        infoWindow: InfoWindow(
          title: site.name,
          snippet: site.type,
        ),
      );
      markers[markerId] = marker;
    }
    setState(() {
      markers = markers;
      loadingWidget = Container();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(38.34306, -84.03564),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            markers: markers.values.toSet(),
            initialCameraPosition: _kGooglePlex,
            onMapCreated: _onMapCreated
          ),
          Center(
            child: Container(
              child: loadingWidget,
            ),
          ),
        ],
      ),
    );
  }
}
