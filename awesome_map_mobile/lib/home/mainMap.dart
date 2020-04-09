import 'package:awesome_map_mobile/home/baseMap.dart';
import 'package:awesome_map_mobile/models/googleMapModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainMap extends StatefulWidget {
  MainMap({Key key}) : super(key: key) {}

  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.white,
              child: const Icon(Icons.my_location, color: Colors.blue),
              onPressed: () {
                Provider.of<GoogleMapModel>(context).setCurrentLocation();
              }),
        ],
      ),
      body: Stack(children: <Widget>[
        BaseMap(),
      ]),
    );
  }
}
