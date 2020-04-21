import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  final Function onChange;
  final DateTime initDate;
  final DateTime firstDate;
  final DateTime endDate;
  final String labelText;
  DatePicker({
    Key key,
    @required this.labelText,
    @required this.initDate,
    @required this.firstDate,
    @required this.endDate,
    @required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Color mainColor = Colors.white;

    return DateTimeField(
        cursorColor: mainColor,
        decoration: InputDecoration(
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
            hintStyle: TextStyle(color: mainColor),
            labelStyle: TextStyle(color: mainColor),
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
            labelText: labelText),
        format: DateFormat.yMMMd(),
        style: TextStyle(
          color: mainColor,
        ),
        onChanged: onChange,
        initialValue: initDate,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: firstDate,
              initialDate: currentValue ?? DateTime.now(),
              lastDate: endDate);
        });
  }
}
