import 'dart:io';

import 'package:awesome_map_mobile/comments/commentsList.dart';
import 'package:awesome_map_mobile/comments/commentsMain.dart';
import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:awesome_map_mobile/services/fileService.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
          resizeToAvoidBottomPadding: false,
          resizeToAvoidBottomInset: false,
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
                      background: event.files.length > 0
                          ? Hero(
                              tag: 'event-details-' + event.id,
                              child: Material(
                                child: event.files[0].path != null
                                    ? Ink.image(
                                        image: FileImage(
                                            File(event.files[0].path)),
                                        fit: BoxFit.cover,
                                        child: Container(),
                                      )
                                    : FutureBuilder<File>(
                                        future: GetIt.I
                                            .get<FileService>()
                                            .getFile(event.files[0]),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.none:
                                            case ConnectionState.waiting:
                                              return CircularProgressIndicator();
                                            case ConnectionState.done:
                                              return Ink.image(
                                                image: snapshot.data != null
                                                    ? FileImage(snapshot.data)
                                                    : Container(),
                                                fit: BoxFit.cover,
                                                child: Container(),
                                              );
                                            default:
                                              if (snapshot.hasError) {
                                                return Text(
                                                  'Pick image error: ${snapshot.error}}',
                                                  textAlign: TextAlign.center,
                                                );
                                              } else {
                                                return const Text(
                                                  'You have not yet picked an image.',
                                                  textAlign: TextAlign.center,
                                                );
                                              }
                                          }
                                        }),
                              ),
                            )
                          : null,
                      title: Text(event.title),
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
                    CommentsMain(
                      event: event
                    )
                  ]),
                ),
              ],
            ),
          )),
    );
  }
}

const List<String> choices = const <String>["Подробніше", "Коментарі"];
