import 'package:awesome_map_mobile/base/baseMap.dart';
import 'package:awesome_map_mobile/base/slidingUpPanelContainer.dart';
import 'package:awesome_map_mobile/models/googleMap/awesomeMarker.dart';
import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:awesome_map_mobile/models/googleMap/markerType.dart';
import 'package:awesome_map_mobile/problems/createProblemItem.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'providers/problemMarkers.dart';
import 'providers/problemForm.dart';

class ProblemMap extends StatefulWidget {
  ProblemMap({Key key}) : super(key: key);

  @override
  _ProblemMapState createState() => _ProblemMapState();
}

class _ProblemMapState extends State<ProblemMap> {
  bool isPrepareAdd = false;
  void _add(ProblemForm model) {
    LatLng currentPosition = context.read<GoogleMapModel>().getCurrentLatLon();
    // model.setLatLon(currentPosition);
    Marker modelMarker = Marker(
        position: currentPosition,
        infoWindow: InfoWindow(
            title: model.problem.title),
        markerId: MarkerId("0"));
    context
        .read<GoogleMapModel>()
        .add(AwesomeMarker(marker: modelMarker, type: MarkerType.Problem));
    context.read<ProblemForm>().setLatLon(currentPosition);
    setState(() {
      isPrepareAdd = false;
    });
  }

  static List<Marker> problems = <Marker>[
    Marker(
      position: LatLng(50.449601, 30.457368),
      infoWindow: InfoWindow(title: 'Test Title'),
      markerId: null,
    )
  ];

  @override
  void initState() {
    super.initState();

    setState(() {
      isPrepareAdd = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProblemForm>(builder: (context, problemFormModel, _) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: getFloatingButton(problemFormModel, context),
        body: Container(
          child: Stack(children: <Widget>[
            BaseMap(filter: MarkerType.Problem),

            // Consumer<ProblemMarkers>(
            //   builder:
            //       (BuildContext context, ProblemMarkers value, Widget child) {
            //     return BaseMap(filter: MarkerType.Problem);
            //   },
            // ),
            SlidingUpPanelContainer(
              isShow: problemFormModel.readyToFill,
              renderChild: (sc) => CreateProblemItem(scrollController: sc),
            ),

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
                    context.read<GoogleMapModel>().setCurrentLocation();
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
