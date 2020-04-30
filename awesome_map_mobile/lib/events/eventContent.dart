import 'package:flutter/material.dart';

class EventContent extends StatefulWidget {
  int id;

  EventContent({Key key, int id}) : super(key: key) {
    this.id = id;
  }
  @override
  _EventContentState createState() => _EventContentState();
  
}

class _EventContentState extends State<EventContent> {
  @override
  Widget build(BuildContext context) {
    int id = widget.id;
    return Column(
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
                      image: id.isOdd ?  AssetImage("images/gitar.jpg") : AssetImage("images/it.jpg"),
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
                            id.isOdd ?"Гітарний вечір" : "Мастер класс Flutter",
                            style: TextStyle(color: Colors.black, fontSize: 25),
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
                      Text( id.isOdd ?"Палац культури" : "Бібліотека НТУУ 'КПІ'")
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
    );
  }
}
