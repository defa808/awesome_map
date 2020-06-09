import 'dart:convert';
import 'dart:io';

import 'package:awesome_map_mobile/events/providers/eventMarkers.dart';
import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:awesome_map_mobile/models/files/serverFile.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/services/eventService.dart';
import 'package:awesome_map_mobile/services/fileService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'createEventItemContent.dart';


class EditEventItem extends StatefulWidget {
  EditEventItem({Key key}) : super(key: key);

  @override
  _EditEventItemState createState() => _EditEventItemState();
}

class _EditEventItemState extends State<EditEventItem> {
  final _formKey = GlobalKey<FormState>();

  List<ServerFile> newFiles = [];
  Event event;
  bool first = false;
  List<String> removedFiles = [];

  @override
  void initState() {
    super.initState();
  }

  addFile(File file) {
    ServerFile serverFile = ServerFile.empty();
    serverFile.path = file.path;
    serverFile.problemId = event.id;
    setState(() {
      this.event.files.add(serverFile);
    });
    newFiles.add(serverFile);
  }

  removeFile(File file) {
    if (this.event.files.any((element) => element.path == file.path)) {
      ServerFile serverFile = this
          .event
          .files
          .firstWhere((x) => x.path == file.path, orElse: null);
      if (serverFile != null) {
        setState(() {
          this.event.files.remove(serverFile);
          newFiles.removeWhere((x) => x.path == file.path);
          removedFiles.add(serverFile.id);
        });
      }
    }
  }

  void updateEntity() async {
    setState(() {
      first = false;
    });
    _formKey.currentState.save();
    if (this.event.title.isEmpty ||
        this.event.description.isEmpty ||
        this.event.startDate == null ||
        this.event.duration == null ||
        this.event.files.length + this.newFiles.length == 0 ||
        this.event.eventTypes.length == 0) {
      setState(() {
        first = true;
      });

      return;
    }
    Event event = await GetIt.I.get<EventService>().update(this.event);
    for (var item in removedFiles) {
      await GetIt.I.get<FileService>().remove(item);
      this.event.files.removeWhere((element) => element.path == item);

    }
    for (ServerFile item in newFiles) {
      ServerFile file =
          await GetIt.I.get<FileService>().save(item, File(item.path));
      this.event.files.removeWhere((element) => element.path == item.path);
      this.event.files.add(file);
    }
      event.files = this.event.files;

    if (event != null) {
      context.read<EventMarkers>().update(event);
      Navigator.pop(context);
    }
  }

  void cancelEntity() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (this.event == null) {
      initEvent();
    }

    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text("Редагування"),
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CreateEventItemContent(
              first: first,
              isEditMode: true,
              formKey: _formKey,
              event: this.event,
              addFile: addFile,
              removeFile: removeFile,
              files: this.event.files.map((x) {
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

  void initEvent() {
    Event event = ModalRoute.of(context).settings.arguments;

    if (event != null) {
      setState(() {
        this.event =
            Event.fromJson(jsonDecode(jsonEncode(event.toJson())));
      });
      this.event.files.forEach((x) async {
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
