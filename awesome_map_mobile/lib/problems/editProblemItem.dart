import 'dart:convert';
import 'dart:io';

import 'package:awesome_map_mobile/models/files/serverFile.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/problems/providers/problemMarkers.dart';
import 'package:awesome_map_mobile/services/fileService.dart';
import 'package:awesome_map_mobile/services/problemService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'createProblemItemContent.dart';

class EditProblemItem extends StatefulWidget {
  EditProblemItem({Key key}) : super(key: key);

  @override
  _EditProblemItemState createState() => _EditProblemItemState();
}

class _EditProblemItemState extends State<EditProblemItem> {
  final _formKey = GlobalKey<FormState>();

  List<ServerFile> newFiles = [];
  Problem problem;

  List<String> removedFiles = [];
  List<ServerFile> existedFile = [];

  @override
  void initState() {
    super.initState();
  }

  addFile(File file) {
    ServerFile serverFile = ServerFile.empty();
    serverFile.path = file.path;
    serverFile.problemId = problem.id;
    setState(() {
      this.problem.files.add(serverFile);
    });
    newFiles.add(serverFile);
  }

  removeFile(File file) {
    if (this.problem.files.any((element) => element.path == file.path)) {
      ServerFile serverFile = this
          .problem
          .files
          .firstWhere((x) => x.path == file.path, orElse: null);
      if (serverFile != null) {
        setState(() {
          this.problem.files.remove(serverFile);
          newFiles.removeWhere((x) => x.path == file.path);
          removedFiles.add(serverFile.id);
        });
      }
    }
  }

  void updateEntity() async {
    _formKey.currentState.save();
    Problem problem = await GetIt.I.get<ProblemService>().update(this.problem);
    for (var item in removedFiles) {
      await GetIt.I.get<FileService>().remove(item);
    }
    for (ServerFile item in newFiles) {
      ServerFile file =
          await GetIt.I.get<FileService>().save(item, File(item.path));
      this.problem.files.removeWhere((element) => element.path == item.path);
      this.problem.files.add(file);
      problem.files = this.problem.files;
    }
    if (problem != null) {
      context.read<ProblemMarkers>().update(problem);
      Navigator.pop(context);
    }
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
          title: Text("Редагування"),
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CreateProblemItemContent(
              isEditMode: true,
              formKey: _formKey,
              problem: this.problem,
              addFile: addFile,
              removeFile: removeFile,
              files: this.problem.files.map((x) {
                if (x.path != null) return File(x.path);
              }).toList(),
              btnOk: FlatButton.icon(
                textColor: Colors.blue,
                icon: Icon(Icons.send, color: Colors.blue),
                label: Text("Відредагувати"),
                onPressed: () {
                  updateEntity();
                },
              ),
              btnCancel: FlatButton.icon(
                  icon: Icon(Icons.clear),
                  label: Text("Скасувати"),
                  onPressed: cancelEntity
                  // removeTicket();
                  ),
            ),
          ),
        ]));
  }

  void initProblem() {
    Problem problem = ModalRoute.of(context).settings.arguments;

    if (problem != null) {
      setState(() {
        this.problem =
            Problem.fromJson(jsonDecode(jsonEncode(problem.toJson())));
      });
      this.problem.files.forEach((x) async {
        if (x.path == null) {
          File file = await GetIt.I.get<FileService>().getFile(x);

          setState(() {
            x.path = file.path;
          });
        }
      });
    }
  }
}
