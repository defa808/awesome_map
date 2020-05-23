import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:flutter/material.dart';

class EventContent extends StatefulWidget {
  EventContent({Key key, this.event}) : super(key: key);
  @override
  _EventContentState createState() => _EventContentState();
  Event event;
}

class _EventContentState extends State<EventContent> {
  @override
  Widget build(BuildContext context) {
    String id = widget.event.id;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 180,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Hero(
                    tag: 'event-details-$id',
                    child: Material(
                      child: Ink.image(
                        image: AssetImage("images/gitar.jpg"),
                        fit: BoxFit.cover,
                        child: Container(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                              "Гітарний вечір",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25),
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
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on),
                        Text("Бібліотека НТУУ 'КПІ'")
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "12.10.19",
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "12:10",
                          style: TextStyle(color: Colors.black, fontSize: 13),
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
