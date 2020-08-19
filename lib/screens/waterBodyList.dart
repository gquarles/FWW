import 'package:FWW/api/WaterBodyApi.dart';
import 'package:FWW/screens/waterBodyDetail.dart';
import 'package:flutter/material.dart';

class WaterBodyListScreen extends StatefulWidget {
  WaterBodyListScreen({Key key}) : super(key: key);

  @override
  _WaterBodyListScreenState createState() => _WaterBodyListScreenState();
}

class _WaterBodyListScreenState extends State<WaterBodyListScreen> {
  WaterBodyApi api = WaterBodyApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Bodies'),
        backgroundColor: Colors.green[900],
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder(
        future: api.getAllWaterBodies(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WaterBodyDetail(
                        waterBody: snapshot.data[index],
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(snapshot.data[index].name),
                  subtitle: Text(snapshot.data[index].typeName),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
