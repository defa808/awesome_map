import 'package:awesome_map_mobile/account/provder/accountProvider.dart';
import 'package:awesome_map_mobile/events/eventItem.dart';
import 'package:awesome_map_mobile/events/providers/eventMarkers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            child: Consumer<AccountProvider>(
              builder: (BuildContext context, AccountProvider account,
                  Widget child) {
                return account.userInfo.observedEventIds.length > 0
                    ? ListView(
                        children: account.userInfo.observedEventIds
                            .map((e) => SelectableEventItem(event: context.watch<EventMarkers>().getEventDetails(e)))
                            .toList(),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Список ваших заходів пустий.",
                                style: TextStyle(fontSize: 20)),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                                "Приєднайтесь до будь-якого запису з мапи або створіть свій.",
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      );
              },
            )));
  }
}
