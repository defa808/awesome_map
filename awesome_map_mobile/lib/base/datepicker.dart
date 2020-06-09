import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  final Function onChange;
  final DateTime initDate;
  final DateTime firstDate;
  final DateTime endDate;
  final String labelText;
  final bool first;
  final bool validate;

  DatePicker(
      {Key key,
      @required this.labelText,
      @required this.initDate,
      @required this.firstDate,
      @required this.endDate,
      @required this.onChange,
      this.first = false,
      this.validate = true,
      this.color = Colors.white})
      : super(key: key);
  Color color;
  @override
  Widget build(BuildContext context) {
    return DateTimeField(
        cursorColor: color,
        decoration: InputDecoration(
          errorText: first && !validate ? "Поле обов'язкове": null,
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: color)),
            hintStyle: TextStyle(color: color),
            labelStyle: TextStyle(color: color),
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: color)),
            labelText: labelText),
        format: DateFormat.yMMMd(),
        style: TextStyle(
          color: color,
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
