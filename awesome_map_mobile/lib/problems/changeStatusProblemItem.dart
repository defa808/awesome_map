import 'dart:convert';
import 'dart:io';

import 'package:awesome_map_mobile/comments/provider/commentProvider.dart';
import 'package:awesome_map_mobile/models/comment/comment.dart';
import 'package:awesome_map_mobile/models/files/serverFile.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/models/problem/problemStatus.dart';
import 'package:awesome_map_mobile/problems/providers/problemMarkers.dart';
import 'package:awesome_map_mobile/services/fileService.dart';
import 'package:awesome_map_mobile/services/problemService.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'createProblemItemContent.dart';

class ChangeStatusProblemItem extends StatefulWidget {
  ChangeStatusProblemItem({Key key}) : super(key: key);

  @override
  _ChangeStatusProblemItemState createState() =>
      _ChangeStatusProblemItemState();
}

class _ChangeStatusProblemItemState extends State<ChangeStatusProblemItem> {
  final _formKey = GlobalKey<FormState>();

  Problem problem;
  String comment = "";
  int status;
  @override
  void initState() {
    super.initState();
  }

  void updateEntity() async {
    if (comment.isNotEmpty) {
      Comment comment = await GetIt.I
          .get<ProblemService>()
          .updateStatusWithComment(this.problem.id, this.status, this.comment);
      if (comment == null) return;
      this.problem.status = status;
      context.read<ProblemMarkers>().update(problem);
      context.read<CommentProvider>().add(problem.id, comment);
    } else {
      if (await GetIt.I
          .get<ProblemService>()
          .updateStatus(this.problem.id, this.status)) {
        this.problem.status = status;
        context.read<ProblemMarkers>().update(problem);
      } else
        return;
    }

    Navigator.pop(context);
  }

  void cancelEntity() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (this.problem == null) {
      initProblem();
    }

    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text("Редагування статуса"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            DropdownButton<ProblemStatus>(
                isExpanded: true,
                selectedItemBuilder: (BuildContext context) {
                  return ProblemStatus.values.map<Widget>((ProblemStatus item) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        EnumToString.parseCamelCase(item),
                      ),
                    );
                  }).toList();
                },
                hint: Text("Статус"),
                onChanged: (ProblemStatus newValue) {
                  setState(() {
                    status = newValue.index;
                  });
                },
                value: this.status >= 0 ? ProblemStatus.values[status] : null,
                items: ProblemStatus.values.map((ProblemStatus classType) {
                  return DropdownMenuItem<ProblemStatus>(
                      value: classType,
                      child: Text(
                        EnumToString.parseCamelCase(classType),
                        style: TextStyle(color: Colors.black),
                      ));
                }).toList()),
            TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Коментар",
                ),
                onChanged: (String value) {
                  this.comment = value;
                }),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                FlatButton.icon(
                  textColor: Colors.blue,
                  icon: Icon(Icons.send, color: Colors.blue),
                  label: Text("Змінити статус"),
                  onPressed: () {
                    updateEntity();
                  },
                ),
                FlatButton.icon(
                    icon: Icon(Icons.clear),
                    label: Text("Скасувати"),
                    onPressed: cancelEntity
                    // removeTicket();
                    ),
              ],
            ),
          ]),
        ));
  }

  void initProblem() {
    Problem problem = ModalRoute.of(context).settings.arguments;

    if (problem != null) {
      setState(() {
        this.problem =
            Problem.fromJson(jsonDecode(jsonEncode(problem.toJson())));
        status = this.problem.status;
      });
    }
  }
}
