import 'package:flutter/material.dart';

class EventContent extends StatefulWidget {
  EventContent({Key key}) : super(key: key);

  @override
  _EventContentState createState() => _EventContentState();
}

class _EventContentState extends State<EventContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 180,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Hero(
                  tag: 'hop-hey',
                  child: Material(
                    child: Ink.image(
                      image: AssetImage("images/gitar.jpg"),
                      fit: BoxFit.cover,
                      child: Container(),
                    ),
                  ),
                ),
              ),
              // Positioned(
              //     top: 16,
              //     right: 16,
              //     child: Column(
              //       crossAxisAlignment:CrossAxisAlignment.end,
              //       children: <Widget>[
              //         FittedBox(
              //             fit: BoxFit.scaleDown,
              //             alignment: Alignment.center,
              //             child: Text(
              //               "12.10.19",
              //               style: TextStyle(color: Colors.white, fontSize: 13),
              //             )),
              //             SizedBox(height: 2),
              //         FittedBox(
              //             fit: BoxFit.scaleDown,
              //             alignment: Alignment.center,
              //             child: Text(
              //               "12:10",
              //               style: TextStyle(color: Colors.white, fontSize: 13),
              //             ))
              //       ],
              //     )),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.black),
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Гітарний вечір",
                        style: TextStyle(color: Colors.black, fontSize: 25),
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
                        Text("Палац культури")
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
          ),
        )
      ],
    );
  }
}
