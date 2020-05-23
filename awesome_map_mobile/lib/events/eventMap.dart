import 'package:awesome_map_mobile/base/baseMap.dart';
import 'package:awesome_map_mobile/events/providers/eventForm.dart';
import 'package:awesome_map_mobile/models/googleMap/awesomeMarker.dart';
import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:awesome_map_mobile/models/googleMap/markerType.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'createEventItem.dart';

class EventMap extends StatefulWidget {
  const EventMap({Key key}) : super(key: key);

  @override
  _EventMapState createState() => _EventMapState();
}

class _EventMapState extends State<EventMap> {
  bool isPrepareAdd = false;

  void _add(EventForm model) {
    LatLng currentPosition = context.read<GoogleMapModel>().getCurrentLatLon();
    // model.setLatLon(currentPosition);
    Marker modelMarker = Marker(
        position: currentPosition,
        infoWindow: InfoWindow(title: model.event.title),
        markerId: MarkerId("0"));
    context
        .read<GoogleMapModel>()
        .add(AwesomeMarker(marker: modelMarker, type: MarkerType.Event));
    context.read<EventForm>().setLatLon(currentPosition);
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
    return Consumer<EventForm>(builder: (context, problemFormModel, _) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: getFloatingButton(problemFormModel, context),
        body: Container(
          child: Stack(children: <Widget>[
            BaseMap(filter: MarkerType.Event),
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
            if (problemFormModel.readyToFill) CreateEventItem(),
          ]),
        ),
      );
    });
  }

  Column getFloatingButton(EventForm eventFormModel, BuildContext context) {
    return eventFormModel.readyToFill
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
                              _add(eventFormModel);
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
