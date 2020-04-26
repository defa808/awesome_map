import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({Key key, this.label, this.icon, this.onDelete})
      : super(key: key);
  final Widget label;
  final Widget icon;
  final Function onDelete;
  @override
  Widget build(BuildContext context) {
    return RawChip(
      avatar: CircleAvatar(
        backgroundColor: Colors.transparent,
        foregroundColor: CustomTheme.of(context).chipTheme.labelStyle.color,
        child: icon,
      ),
      label: label,
      onDeleted: onDelete,
      deleteIcon: Icon(Icons.clear),
      backgroundColor: CustomTheme.of(context).chipTheme.backgroundColor,
    );
  }
}
