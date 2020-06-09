import 'dart:io';

import 'package:awesome_map_mobile/base/chooseCategoryAutoComplete.dart';
import 'package:awesome_map_mobile/base/datepicker.dart';
import 'package:awesome_map_mobile/base/filePicker.dart';
import 'package:awesome_map_mobile/base/filter/categoryItem.dart';
import 'package:awesome_map_mobile/base/timePicker.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:awesome_map_mobile/services/eventService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CreateEventItemContent extends StatefulWidget {
  CreateEventItemContent(
      {Key key,
      this.isEditMode = false,
      this.event,
      this.btnOk,
      this.btnCancel,
      this.files,
      this.addFile,
      this.removeFile,
      this.formKey,
      this.first = false})
      : super(key: key);

  final Event event;
  final List<File> files;
  final void Function(File) addFile;
  final void Function(File) removeFile;
  final Widget btnOk;
  final Widget btnCancel;
  final GlobalKey<FormState> formKey;
  final bool isEditMode;
  final bool first;

  @override
  _CreateEventItemContentState createState() => _CreateEventItemContentState();
}

class _CreateEventItemContentState extends State<CreateEventItemContent> {
  TextEditingController nameController;
  TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.event.title);
    descriptionController =
        TextEditingController(text: widget.event.description);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (!widget.isEditMode)
            Center(
              child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(18))),
            ),
          if (!widget.isEditMode) SizedBox(height: 5),
          if (!widget.isEditMode)
            Row(
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Широта",
                          hintText: "Широта"),
                      keyboardType: TextInputType.number,
                      initialValue: widget.event.latitude.toString(),
                      onSaved: (String value) {
                        widget.event.latitude = double.parse(value);
                      }),
                ),
                SizedBox(width: 50),
                Flexible(
                  child: TextFormField(
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Довгота",
                          hintText: "Довгота"),
                      keyboardType: TextInputType.number,
                      initialValue: widget.event.longitude.toString(),
                      onSaved: (String value) {
                        widget.event.longitude = double.parse(value);
                      }),
                ),
              ],
            ),
          if (widget.event.eventTypes.length > 0) SizedBox(height: 10),
          Wrap(
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.start,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                for (Category item in widget.event.eventTypes)
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: CategoryItem(
                        label: Text(item.name),
                        icon: item.icon != null
                            ? Icon(IconData(item.icon.iconCode,
                                fontFamily: item.icon.fontFamily,
                                fontPackage: item.icon.fontPackage))
                            : null,
                        onDelete: () {
                          widget.event.removeCategory(item.id);
                          setState(() {});
                        }),
                  )
              ]),
          ChooseCategoryAutoComplete(
            getStore: GetIt.I.get<EventService>().getCategories,
            selectedCategories: widget.event.eventTypes,
            addCategory: (Category category) {
              widget.event.addCategory(category);
              setState(() {});
            },
            validate: widget.event.eventTypes.length != 0,
            first: widget.first,
          ),
          SizedBox(height: 10),
          TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Назва",
                  errorText: widget.first && nameController.value.text.isEmpty
                      ? "Введіть назву."
                      : null),
              onSaved: (String value) {
                widget.event.title = value;
              }),
          SizedBox(height: 10),
          TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: descriptionController,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Опис",
                  errorText:
                      widget.first && descriptionController.value.text.isEmpty
                          ? "Введіть опис."
                          : null),
              onSaved: (String value) {
                widget.event.description = value;
              }),
          SizedBox(height: 10),
          DatePicker(
            color: Colors.black,
            labelText: "Дата проведення",
            initDate: DateTime.now(),
            endDate: DateTime.now().add(Duration(days: 365 * 2)),
            first: widget.first,
            validate: widget.event.startDate != null,
            onChange: (value) {
              widget.event.startDate = value;
            },
            firstDate: DateTime(2020),
          ),
          SizedBox(height: 10),
          TimePicker(
            first: widget.first,
            validate: widget.event.duration != null,
            labelText: "Тривалість",
            color: Colors.black,
            onChange: (val) {
              widget.event.duration = val;
            },
          ),
          SizedBox(height: 10),
          FilePicker(
            first: widget.first,
            validate: widget.files.length != 0,
            addFile: widget.addFile,
            removeFile: widget.removeFile,
            files: widget.files,
          ),
          SizedBox(height: 10),
          Divider(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              widget.btnOk, widget.btnCancel
              // FlatButton.icon(
              //   textColor: Colors.blue,
              //   icon: Icon(Icons.send, color: Colors.blue),
              //   label: Text("Відправити"),
              //   onPressed: () {
              //     completeTicket();
              //   },
              // ),
              // FlatButton.icon(
              //   icon: Icon(Icons.clear),
              //   label: Text("Скасувати"),
              //   onPressed: () {
              //     removeTicket();
              //   },
              // ),
            ],
          )
        ],
      ),
    );
  }
}
