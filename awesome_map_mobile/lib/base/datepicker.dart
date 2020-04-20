import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  final Function onChange;
  final DateTime initDate;
  final String labelText;
  DatePicker({Key key, @required this.labelText, @required this.initDate, @required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color mainColor = Colors.white;

    return DateTimeField(
        cursorColor: mainColor,
        decoration: InputDecoration(
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
            suffixIcon: Icon(
              Icons.clear,
              color: mainColor,
            ),
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
        //  (value) {
        //   model.setDate(value);
        // },
        initialValue: initDate, //model.startDate,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        });
  }
}
