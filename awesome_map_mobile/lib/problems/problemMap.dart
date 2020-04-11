import 'package:awesome_map_mobile/home/baseMap.dart';
import 'package:awesome_map_mobile/models/googleMapModel.dart';
import 'package:awesome_map_mobile/models/problemForm.dart';
import 'package:awesome_map_mobile/problems/createProblemItem.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ProblemMap extends StatefulWidget {
  ProblemMap({Key key}) : super(key: key);

  @override
  _ProblemMapState createState() => _ProblemMapState();
}

class _ProblemMapState extends State<ProblemMap> {
  bool isPrepareAdd = false;

  void _add(ProblemForm model) {
    LatLng currentPosition = Provider.of<GoogleMapModel>(context).getCurrentLatLon();
    model.setLatLon(currentPosition);
    Provider.of<GoogleMapModel>(context).add(model);
    Provider.of<ProblemForm>(context).setLatLon(currentPosition);
    setState(() {
      isPrepareAdd = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isPrepareAdd = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProblemForm>(builder: (context, model, _) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: model.readyToFill
            ? null
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.my_location, color: Colors.blue),
                      onPressed: () {
                        Provider.of<GoogleMapModel>(context)
                            .setCurrentLocation();
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  isPrepareAdd
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FloatingActionButton(
                                child: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    isPrepareAdd = !isPrepareAdd;
                                  });
                                }),
                            SizedBox(
                              width: 10,
                            ),
                            FloatingActionButton(
                                heroTag: null,
                                child: const Icon(Icons.done),
                                onPressed: () {
                                  _add(model);
                                }),
                          ],
                        )
                      : FloatingActionButton(
                          heroTag: null,
                          child: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              isPrepareAdd = !isPrepareAdd;
                            });
                          }),
                ],
              ),
        body: Container(
          child: Stack(children: <Widget>[
            BaseMap(),
            if (isPrepareAdd)
              Center(
                child: Container(
                  height: 90,
                  width: 45,
                  child: Align(
                      alignment: FractionalOffset.topCenter,
                      child:
                          Icon(Icons.location_on, color: Colors.red, size: 45)),
                ),
              ),
            if (model.readyToFill) CreateProblemItem(),
          ]),
        ),
      );
    });
  }
}
