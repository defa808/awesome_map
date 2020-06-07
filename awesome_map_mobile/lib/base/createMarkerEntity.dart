import 'package:flutter/material.dart';

class CreateMarkerEntity extends StatelessWidget {
  const CreateMarkerEntity({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            height: 90,
            width: 45,
            child: Align(
                alignment: FractionalOffset.topCenter,
                child: Icon(Icons.location_on, color: Colors.red, size: 45))));
  }
}
