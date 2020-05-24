import 'package:awesome_map_mobile/events/providers/eventMarkers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'eventItem.dart';

class EventList extends StatefulWidget {
  EventList({Key key}) : super(key: key);

  @override
  _EventList createState() => _EventList();
}

class _EventList extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> events = context
        .watch<EventMarkers>()
        .filteredEvents
        .map<Widget>((x) => SelectableEventItem(
              event: x,
              isSelectable: false,
            ))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: events),
    );
  }
}
