import 'package:flutter/material.dart';

import 'eventContent.dart';

class SelectableEventItem extends StatefulWidget {
  SelectableEventItem({Key key}) : super(key: key);

  @override
  _SelectableEventItemState createState() => _SelectableEventItemState();
}

class _SelectableEventItemState extends State<SelectableEventItem> {
  var _isSelected = false;
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: InkWell(
        onLongPress: () {
          print('Selectable card state changed');
          setState(() {
            _isSelected = !_isSelected;
          });
        },
        onTap: (){
          Navigator.pushNamed(context,'/event', arguments: {'id':1});
        },
        splashColor: colorScheme.onSurface.withOpacity(0.12),
        highlightColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
                color: _isSelected
                    ? colorScheme.primary.withOpacity(0.08)
                    : Colors.transparent),
            EventContent(),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Icon(Icons.check_circle,
                                    color: _isSelected
                                        ? colorScheme.primary
                                        : Colors.transparent)),
                          )
                        ],
                      ),
                    ),
                  );
                }
              }
              
         
