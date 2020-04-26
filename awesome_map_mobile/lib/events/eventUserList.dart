import 'package:awesome_map_mobile/events/eventItem.dart';
import 'package:flutter/material.dart';

class EventUserList extends StatelessWidget {
  const EventUserList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Заходи'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
              children: List.generate(10, (i) => SelectableEventItem(id: i))),
        ));
  }
}