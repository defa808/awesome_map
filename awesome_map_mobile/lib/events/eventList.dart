import 'package:flutter/material.dart';

import 'eventItem.dart';

class EventList extends StatefulWidget {
  EventList({Key key}) : super(key: key);

  @override
  _EventList createState() => _EventList();
}

class _EventList extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    Widget templateWidget = SelectableEventItem();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Заходи'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(children: List.generate(1, (i) => templateWidget)),
        ));
  }
}
