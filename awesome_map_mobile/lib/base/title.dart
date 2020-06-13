import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;
  Header({Key key, @required this.text, this.tool}) : super(key: key);
  Widget tool;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Text(
            text,
            maxLines: 3,
            style: TextStyle(fontSize: 20),
          ),
        ),
        if (this.tool != null) this.tool,
      ],
    );
  }
}
