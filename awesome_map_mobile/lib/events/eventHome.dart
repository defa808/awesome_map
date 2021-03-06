import 'package:awesome_map_mobile/base/filterContainer.dart';
import 'package:awesome_map_mobile/base/slidingUpPanelContainer.dart';
import 'package:awesome_map_mobile/base/title.dart';
import 'package:awesome_map_mobile/events/eventDetailsContent.dart';
import 'package:awesome_map_mobile/events/providers/eventFilterModel.dart';
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
    
  }

  void loadData() async {
    GoogleMapModel googleMapProvider = context.read<GoogleMapModel>();
    EventMarkers eventMarkersProvider = context.read<EventMarkers>();
    EventFilterModel filterProvider = context.read<EventFilterModel>();

    await eventMarkersProvider.getEvents();
      filterProvider.addListener(() {
      eventMarkersProvider.updateFilter(filterProvider);
      googleMapProvider.updateMarkers(eventMarkersProvider.createMarkers(),
          markerType: MarkerType.Event);
    });
    googleMapProvider.updateMarkers(eventMarkersProvider.createMarkers(),
        markerType: MarkerType.Event);
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
                if (model.selectedMarker != null)
                  Consumer<EventMarkers>(
                    builder: (BuildContext context, EventMarkers eventMarkers,
                        Widget child) {
                      Event event = eventMarkers
                          .getEventDetails(model.selectedMarker.value);

                      return event != null
                          ? SlidingUpPanelContainer(
                              renderChild: (sc) => MapDetails(
                                    title: Header(
                                      text: event?.title,
                                    ),
                                    child: EventDetailsContent(event),
                                    scrollController: sc,
                                  ),
                              isShow: selectedItemLast != null)
                          : Container();
                    },
                  ),
              ]),
                FilterContainer(child: EventFilter())

      ]);
    });
  }
}
