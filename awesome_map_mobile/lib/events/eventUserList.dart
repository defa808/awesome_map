import 'package:awesome_map_mobile/events/eventItem.dart';
import 'package:awesome_map_mobile/events/providers/eventMarkers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventUserList extends StatelessWidget {
  const EventUserList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> events = context
        .watch<EventMarkers>()
        .filteredEvents
        .map<Widget>((x) => SelectableEventItem(event: x))
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Заходи'),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: events,
            )));
  }
}
