import 'package:awesome_map_mobile/base/baseMap.dart';
import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainMap extends StatefulWidget {
  Function changeTitleAppBar;
  MainMap({Key key, Function changeTitle}) : super(key: key) {
    changeTitleAppBar = changeTitle;
  }

  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  @override
  void dispose() {
    super.dispose();
  }

@override
void initState() {
    super.initState();
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
               context.read<GoogleMapModel>().setCurrentLocation();
              }),
        ],
      ),
      body: Stack(children: <Widget>[
        BaseMap(),
      ]),
    );
  }
}
