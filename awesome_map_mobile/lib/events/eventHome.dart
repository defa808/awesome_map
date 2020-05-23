import 'package:awesome_map_mobile/base/filterContainer.dart';
import 'package:awesome_map_mobile/base/slidingUpPanelContainer.dart';
import 'package:awesome_map_mobile/base/title.dart';
import 'package:awesome_map_mobile/events/eventDetailsContent.dart';
import 'package:awesome_map_mobile/events/providers/eventMarkers.dart';
import 'package:awesome_map_mobile/home/mapDetails.dart';
import 'package:awesome_map_mobile/home/mapListButton.dart';
import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:awesome_map_mobile/models/googleMap/markerType.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'eventList.dart';
import 'eventMap.dart';
import 'eventMapDetails.dart';
import 'filter/eventFilter.dart';

class EventHome extends StatefulWidget {
  EventHome({Key key}) : super(key: key);

  @override
  _ProblemHomeState createState() => _ProblemHomeState();
}

class _ProblemHomeState extends State<EventHome> {
  bool isShowList = false;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    context.read<EventMarkers>().getEvents();
  }

  void showMap() {
    setState(() {
      isShowList = false;
    });
  }

  Widget mapListButton;
  MarkerId selectedItemLast;
  @override
  Widget build(BuildContext context) {
    // Provider.of<GoogleMapModel>(context, listen: false).addListener(() {
    //   MarkerId selectedItem =
    //       Provider.of<GoogleMapModel>(context, listen: false).getSelectedItem();
    // });
    return Consumer<GoogleMapModel>(
        builder: (BuildContext context, GoogleMapModel model, Widget child) {
      return Consumer<EventMarkers>(builder:
          (BuildContext context, EventMarkers eventMarkers, Widget child) {
        context.watch<GoogleMapModel>().updateMarkers(
            eventMarkers.createMarkers(),
            markerType: MarkerType.Event);

        MarkerId selectedItem = model.selectedMarker;
        if (selectedItemLast != selectedItem) isShowList = false;
        selectedItemLast = selectedItem;

        mapListButton = MapListButton(
          initialValue: isShowList ? 1 : 0,
          onListChange: () => setState(
            () {
              isShowList = true;
            },
          ),
          onMapChange: () => setState(() {
            isShowList = false;
          }),
        );

        Event event;
        if (selectedItemLast != null)
          event = eventMarkers.getEventDetails(selectedItemLast.value);

        return Stack(children: <Widget>[
          isShowList
              ? Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: mapListButton,
                    ),
                    Divider(),
                    Expanded(child: EventList()),
                  ],
                )
              : Stack(children: <Widget>[
                  EventMap(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: mapListButton,
                  ),
                  if (selectedItemLast != null)
                    SlidingUpPanelContainer(
                        renderChild: (sc) => MapDetails(
                              title: Header(
                                text: event?.title,
                              ),
                              child: EventMapDetails(event),
                              scrollController: sc,
                            ),
                        isShow: selectedItemLast != null),
                  // FilterContainer(child: EventFilter())
                ])
        ]);
      });
    });
  }
}
