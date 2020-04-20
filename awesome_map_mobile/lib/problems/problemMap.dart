import 'package:awesome_map_mobile/base/baseMap.dart';
import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:awesome_map_mobile/models/problem/problemForm.dart';
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
    LatLng currentPosition =
        Provider.of<GoogleMapModel>(context).getCurrentLatLon();
    // model.setLatLon(currentPosition);
    Marker modelMarker = Marker(
        position: currentPosition,
        infoWindow: InfoWindow(title: model.title, snippet: model.description),
        markerId: null);
    Provider.of<GoogleMapModel>(context).add(modelMarker);
    Provider.of<ProblemForm>(context).setLatLon(currentPosition);
    setState(() {
      isPrepareAdd = false;
    });
  }

  static List<Marker> problems = <Marker>[
    Marker(
      position: LatLng(50.449601, 30.457368),
      infoWindow: InfoWindow(title: 'Test Title', snippet: 'Sub Description'),
      markerId: null,
    )
  ];

  @override
  void initState() {
    super.initState();
    // Provider.of<GoogleMapModel>(context).initMarker(problems);

    setState(() {
      isPrepareAdd = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<ProblemForm>(builder: (context, problemFormModel, _) {
      // config.setSettings(
      //     floatingButton: getFloatingButton(problemFormModel, context));
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: getFloatingButton(problemFormModel, context),
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
            if (problemFormModel.readyToFill) CreateProblemItem(),
          ]),
        ),
      );
    });
  }

  Column getFloatingButton(ProblemForm problemFormModel, BuildContext context) {
    return problemFormModel.readyToFill
        ? null
        : Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.my_location, color: Colors.blue),
                  onPressed: () {
                    Provider.of<GoogleMapModel>(context).setCurrentLocation();
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
                              _add(problemFormModel);
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
          );
  }
}
