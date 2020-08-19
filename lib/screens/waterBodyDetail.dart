import 'package:FWW/api/WaterBodyApi.dart';
import 'package:flutter/material.dart';

class WaterBodyDetail extends StatefulWidget {
  WaterBodyDetail({Key key, this.waterBody}) : super(key: key);

  final WaterBody waterBody;

  @override
  _WaterBodyDetailState createState() => _WaterBodyDetailState();
}

class _WaterBodyDetailState extends State<WaterBodyDetail> {
  @override
  Widget build(BuildContext context) {
    String imgDesc;

    if (widget.waterBody.imgDesc == null)
      imgDesc = 'NULL';
    else
      imgDesc = widget.waterBody.imgDesc;

    return Scaffold(
      appBar: AppBar(
        title: Text('Water Body'),
        backgroundColor: Colors.green[900],
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Image.network(widget.waterBody.imgUrl),
          Text(imgDesc),
        ],
      ),
    );
  }
}
