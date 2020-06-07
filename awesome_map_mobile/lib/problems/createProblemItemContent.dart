import 'dart:io';

import 'package:awesome_map_mobile/base/chooseCategoryAutoComplete.dart';
import 'package:awesome_map_mobile/base/filePicker.dart';
import 'package:awesome_map_mobile/base/filter/categoryItem.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/services/problemService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CreateProblemItemContent extends StatefulWidget {
  CreateProblemItemContent(
      {Key key,
      this.isEditMode = false,
      this.problem,
      this.btnOk,
      this.btnCancel,
      this.files,
      this.addFile,
      this.removeFile,
      this.formKey,
      this.first})
      : super(key: key);
  final Problem problem;
  final List<File> files;
  final void Function(File) addFile;
  final void Function(File) removeFile;
  final Widget btnOk;
  final Widget btnCancel;
  final GlobalKey<FormState> formKey;
  final bool isEditMode;
  final bool first;
  @override
  _CreateProblemItemContentState createState() =>
      _CreateProblemItemContentState();
}

class _CreateProblemItemContentState extends State<CreateProblemItemContent> {
  TextEditingController nameController;
  TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.problem.title);
    descriptionController =
        TextEditingController(text: widget.problem.description);
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
                      controller: TextEditingController()
                        ..text = widget.problem.latitude.toString(),
                      onSaved: (String value) {
                        widget.problem.latitude = double.parse(value);
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
                      controller: TextEditingController()
                        ..text = widget.problem.longitude.toString(),
                      onSaved: (String value) {
                        widget.problem.longitude = double.parse(value);
                      }),
                ),
              ],
            ),
          if (widget.problem.problemTypes.length > 0)
            SizedBox(
              height: 10,
            ),
          Wrap(
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.start,
              alignment: WrapAlignment.start,
              runSpacing: 0.0,
              spacing: 0.0,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                for (Category item in widget.problem.problemTypes)
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
                          widget.problem.removeCategory(item.id);
                          setState(() {});
                        }),
                  )
              ]),
          ChooseCategoryAutoComplete(
              getStore: GetIt.I.get<ProblemService>().getCategories,
              selectedCategories: widget.problem.problemTypes,
              validate: widget.problem.problemTypes.length != 0,
              first: widget.first,
              addCategory: (Category category) {
                widget.problem.addCategory(category);
                setState(() {});
              }),
          TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: nameController,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Назва",
                  errorText: widget.first && nameController.value.text.isEmpty
                      ? "Введіть назву."
                      : null),
              onSaved: (String value) {
                widget.problem.title = value;
              }),
          SizedBox(height: 10),
          TextFormField(
              controller: descriptionController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Опис",
                  errorText:
                      widget.first && descriptionController.value.text.isEmpty
                          ? "Введіть опис."
                          : null),
              onSaved: (String value) {
                widget.problem.description = value;
              }),
          SizedBox(height: 10),
          FilePicker(
            first: widget.first,
            validate: widget.problem.files.length != 0,
            addFile: widget.addFile,
            removeFile: widget.removeFile,
            files: widget.files,
          ),
          SizedBox(height: 10),
          Divider(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[widget.btnOk, widget.btnCancel],
          ),
        ],
      ),
    );
  }
}
