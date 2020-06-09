import 'dart:io';

import 'package:awesome_map_mobile/base/locationPlace.dart';
import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:awesome_map_mobile/services/fileService.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItemContent extends StatefulWidget {
  EventItemContent({Key key, this.event}) : super(key: key);
  @override
  _EventItemContentState createState() => _EventItemContentState();
  final Event event;
}

class _EventItemContentState extends State<EventItemContent> {
  @override
  Widget build(BuildContext context) {
    String id = widget.event.id;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.event.files.length > 0)
            FutureBuilder<File>(
                future:
                    GetIt.I.get<FileService>().getFile(widget.event.files[0]),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    case ConnectionState.done:
                      return SizedBox(
                        height: 180,
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Hero(
                                tag: 'event-details-$id',
                                child: Material(
                                  child: Ink.image(
                                    image: FileImage(snapshot.data),
                                    fit: BoxFit.cover,
                                    child: Container(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          children: <Widget>[
                            Text(
                              widget.event.title,
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                                          child: Row(children: <Widget>[
                        Icon(Icons.location_on),
                        LocationPlace(
                            latitude: widget.event.latitude,
                            longitude: widget.event.longitude),
                      ]),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          DateFormat.yMd()
                              .format(widget.event.startDate)
                              .toString(),
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(height: 2),
                        Text(
                          DateFormat.Hm()
                              .format(widget.event.startDate)
                              .toString(),
                          style: TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
