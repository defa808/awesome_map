import 'package:awesome_map_mobile/comments/commentsList.dart';
import 'package:awesome_map_mobile/comments/commentsMain.dart';
import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';

import 'eventDetailsContent.dart';

class EventDetails extends StatefulWidget {
  EventDetails({Key key}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    Event event = ModalRoute.of(context).settings.arguments;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomPadding: true,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    floating: true,
                    pinned: true,
                    snap: true,
                    expandedHeight: 200.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: 'event-details-' + event.id,
                        child: Material(
                          child: Ink.image(
                            image: AssetImage('images/gitar.jpg'),
                            fit: BoxFit.cover,
                            child: Container(),
                          ),
                        ),
                      ),
                      title: Text("Гітарний вечір"),
                    )),
              ];
            },
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                TabBar(
                  labelColor: CustomTheme.of(context).primaryColor,
                  unselectedLabelColor:
                      CustomTheme.of(context).primaryColor.withOpacity(0.3),
                  tabs: <Widget>[
                    Tab(
                      text: "Детальніше",
                    ),
                    Tab(
                      text: "Коментарії",
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: EventDetailsContent(event),
                    ),
                    CommentsMain()
                  ]),
                ),
              ],
            ),
          )),
    );
  }
}

const List<String> choices = const <String>["Подробніше", "Коментарі"];
