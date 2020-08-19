import 'package:FWW/api/WaterAccessApi.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WaterAccessMap extends StatefulWidget {
  WaterAccessMap({Key key}) : super(key: key);

  @override
  _WaterAccessMapState createState() => _WaterAccessMapState();
}

class _WaterAccessMapState extends State<WaterAccessMap> {
  Widget loadingWidget = CircularProgressIndicator();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

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

  static final CameraPosition _dummyStartPos = CameraPosition(
    target: LatLng(38.34306, -84.03564),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('Access Sites'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('pressed');
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              print('pressed');
            },
          )
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
              mapType: MapType.normal,
              markers: markers.values.toSet(),
              initialCameraPosition: _dummyStartPos,
              onMapCreated: _onMapCreated),
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
