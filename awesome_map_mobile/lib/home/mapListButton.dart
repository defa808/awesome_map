import 'package:flutter/material.dart';

class MapListButton extends StatefulWidget {
  const MapListButton({Key key}) : super(key: key);

  @override
  _MapListButtonState createState() => _MapListButtonState();
}

class _MapListButtonState extends State<MapListButton>
    with SingleTickerProviderStateMixin {
  List<bool> _selections = [true, false];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: ToggleButtons(
          color: Colors.grey,
          renderBorder: false,
          selectedColor: Colors.blue,
          borderRadius: BorderRadius.circular(30),
          children: <Widget>[Icon(Icons.map), Icon(Icons.list)],
          isSelected: _selections,
          onPressed: (int index) {
            setState(() {
             for (var i = 0; i < _selections.length; i++) {
               _selections[i] = false;
             }
              _selections[index] = true;
            });
          },
        ),
      ),
    );
  }
}
