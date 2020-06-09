import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePicker extends StatefulWidget {
  final Function onChange;
  final String labelText;
  TimePicker({
    Key key,
    this.first = false,
    this.validate = true,
    @required this.labelText,
    @required this.onChange,
    this.color = Colors.white,
  }) : super(key: key);
  Color color;
  bool first;
  bool validate;
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final timeController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        cursorColor: widget.color,
        controller: timeController,
        decoration: InputDecoration(
            errorText:
                widget.first && !widget.validate ? "Поле обов'язкове" : null,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.color)),
            hintStyle: TextStyle(color: widget.color),
            labelStyle: TextStyle(color: widget.color),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.color)),
            labelText: widget.labelText),
        focusNode: FocusNode(canRequestFocus: false),
        style: TextStyle(
          color: widget.color,
        ),
        onTap: () async {
          TimeOfDay time = await showTimePicker(
              context: context, initialTime: TimeOfDay(minute: 0, hour: 0));
          if (time == null) return;
          this
              .widget
              .onChange(Duration(hours: time.hour, minutes: time.minute));
          timeController.text = time.format(context);
        });
  }
}
