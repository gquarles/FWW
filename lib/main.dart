import 'package:FWW/screens/FINSMap.dart';
import 'package:FWW/screens/waterAccessMap.dart';
import 'package:FWW/screens/waterBodyList.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Kentucky Department of',
              overflow: TextOverflow.fade,
            ),
            Text(
              'Fish and Wildlife',
              overflow: TextOverflow.fade,
            )
          ],
        ),
        backgroundColor: Colors.green[900],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  height: 120,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WaterBodyListScreen(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 20,
                      child: Center(
                        child: Text('Water Bodies'),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  height: 120,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WaterAccessMap(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 20,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Fishing & Boating'),
                            Text('Access Sites'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  height: 120,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FINSMap(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 20,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Fishing in'),
                            Text('Neighborhoods'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  height: 120,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WaterAccessMap(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 20,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('My Profile'),
                            Text('(Purchase License)'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
