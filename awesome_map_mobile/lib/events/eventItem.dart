import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';

import 'eventItemContent.dart';


class SelectableEventItem extends StatefulWidget {
  SelectableEventItem({Key key, @required this.event, this.isSelectable = true})
      : super(key: key);
  final Event event;
  final bool isSelectable;
  @override
  _SelectableEventItemState createState() => _SelectableEventItemState();
}

class _SelectableEventItemState extends State<SelectableEventItem> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = CustomTheme.of(context).colorScheme;
    return Card(
      child: InkWell(
        onLongPress: () {
          if (this.widget.isSelectable)
            setState(() {
              _isSelected = !_isSelected;
            });
        },
        onTap: () {
          Navigator.pushNamed(context, '/event', arguments: widget.event);
        },
        splashColor: colorScheme.onSurface.withOpacity(0.12),
        highlightColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
                color: _isSelected
                    ? colorScheme.primary.withOpacity(0.08)
                    : Colors.transparent),
            EventItemContent(event: widget.event),
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
