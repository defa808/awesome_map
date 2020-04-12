import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';

class MapListButton extends StatefulWidget {
  final int initialValue;
  final Function() onMapChange;
  final Function() onListChange;
  const MapListButton(
      {Key key,
      @required this.initialValue,
      @required this.onMapChange,
      @required this.onListChange})
      : super(key: key);

  @override
  _MapListButtonState createState() => _MapListButtonState();
}

class _MapListButtonState extends State<MapListButton>
    with SingleTickerProviderStateMixin {
  List<bool> _selections; //[true, false];

  @override
  void initState() {
    super.initState();
    _selections = List.generate(2, (int index) {
      return widget.initialValue == index;
    });
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
            color: CustomTheme.of(context).toggleButtonsTheme.fillColor, borderRadius: BorderRadius.circular(30)),
        child: ToggleButtons(
          color: CustomTheme.of(context).toggleButtonsTheme.color,
          renderBorder: false,
          selectedColor: CustomTheme.of(context).toggleButtonsTheme.selectedColor,
          borderRadius: BorderRadius.circular(30),
          children: <Widget>[Icon(Icons.map), Icon(Icons.list)],
          isSelected: _selections,
          onPressed: (int index) {
            setState(() {
              for (var i = 0; i < _selections.length; i++) {
                _selections[i] = false;
              }
              _selections[index] = true;
              if (index == 0)
                widget.onMapChange();
              else
                widget.onListChange();
            });
          },
        ),
      ),
    );
  }
}
