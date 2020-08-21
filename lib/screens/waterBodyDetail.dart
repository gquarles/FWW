import 'package:FWW/api/WaterBodyApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

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
      imgDesc = '';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.waterBody.imgUrl),
            Text(imgDesc),
            Text(
              widget.waterBody.name,
              style: TextStyle(fontSize: 20.0),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(widget.waterBody.notes),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.cyan, shape: BoxShape.circle),
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.navigation),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              child: ListTile(
                leading: Icon(
                  Icons.info,
                  size: 40,
                ),
                title: Html(
                  data: widget.waterBody.desc,
                  onLinkTap: (url) {
                    _launchURL(url);
                  },
                ),
              ),
            )
          ],
        ),
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
