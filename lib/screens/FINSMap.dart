import 'package:FWW/api/FINSApi.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FINSMap extends StatefulWidget {
  FINSMap({Key key}) : super(key: key);

  @override
  _FINSMapState createState() => _FINSMapState();
}

class _FINSMapState extends State<FINSMap> {
  Widget loadingWidget = CircularProgressIndicator();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  _onMapCreated(GoogleMapController controller) async {
    FINSApi api = FINSApi();

    List<FIN> sites = await api.getAllFINS();

    markers.clear();
    for (FIN site in sites) {
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
    target: LatLng(38.173989, -84.922899),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('FINS'),
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
