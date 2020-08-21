import 'package:FWW/screens/FINSMap.dart';
import 'package:FWW/screens/waterAccessMap.dart';
import 'package:FWW/screens/waterBodyList.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
            ),
            items: [
              'https://www.wmky.org/sites/wmky/files/styles/medium/public/201901/saugeyeohior0002.JPG',
              'https://kentuckylakegateway.com/wp-content/uploads/2018/03/12-6-hooked-fish.jpg',
              'https://d2fxn1d7fsdeeo.cloudfront.net/kentuckyliving.com/wp-content/uploads/2018/10/04152005/Ohio-River-catfish-from-2018.jpg'
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Image.network(i);
                },
              );
            }).toList(),
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
                      _launchURL('https://app.fw.ky.gov/myprofile/');
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
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: Colors.green[900],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text('News'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more),
            title: Text('More'),
          ),
        ],
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
