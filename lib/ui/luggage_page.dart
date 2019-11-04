import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:transparent_image/transparent_image.dart';

class LuggagePage extends StatelessWidget {
  const LuggagePage({
    Key key,
    @required this.thumbnail,
    @required this.id,
    @required this.length,
    @required this.width,
    @required this.height,
    @required this.scannedTime,
    @required this.index,
  }) : super(key: key);

  final String thumbnail;
  final int id;
  final double length;
  final double width;
  final double height;
  final String scannedTime;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        panel: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 12.0,
              ),
              Container(
                width: 56,
                height: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                    color: Colors.black38),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.business_center),
                      title: Text('Luggage ID'),
                      subtitle: Text("$id"),
                    ),
                    ListTile(
                      leading: Icon(Icons.aspect_ratio),
                      title: Text('Luggage size'),
                      subtitle: Text(
                          "$length cm x $width cm x $height cm (${(length * width * height).round()} cm^3)"),
                    ),
                    ListTile(
                      leading: Icon(Icons.access_time),
                      title: Text('Scanned time'),
                      subtitle: Text(scannedTime),
                    ),
                    ListTile(
                      leading: Icon(Icons.assignment_returned),
                      title: Text('Assigned index'),
                      subtitle: Text("$index"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: Hero(
                tag: 'luggage-$id',
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 24,
                ),IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            )
          ]
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        boxShadow: [BoxShadow(blurRadius: 20.0, color: Colors.black)],
        parallaxEnabled: true,
        parallaxOffset: .5,
      ),
    );
  }
}
