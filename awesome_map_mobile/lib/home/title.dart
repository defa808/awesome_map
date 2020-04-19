import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;
  Header({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Text(
            text,
            maxLines: 3,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
