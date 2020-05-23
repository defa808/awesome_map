import 'dart:io';

import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:awesome_map_mobile/models/files/serverFile.dart';
import 'package:awesome_map_mobile/services/eventService.dart';
import 'package:awesome_map_mobile/services/fileService.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventForm with ChangeNotifier {
  bool readyToFill = false;
  Event event = Event.empty();
  List<File> files = new List<File>();

  void setLatLon(LatLng position) {
    this.event.latitude = num.parse(position.latitude.toStringAsFixed(10));
    this.event.longitude = num.parse(position.longitude.toStringAsFixed(10));
    this.readyToFill = true;
    this.notifyListeners();
  }

  Future<bool> save() async {
    try {
      this.event = await EventService.save(this.event);
      ServerFile fileInfo = ServerFile.empty();
      fileInfo.problemId = this.event.id;
      for (File item in files) {
        fileInfo = await FileService.save(fileInfo, item);
        this.event.files.add(fileInfo);
      }

      readyToFill = false;
      return true;
    } catch (e) {
      print(e.message.toString());
    }
    return false;
    // this.latitude = form.latitude;
    // this.longitude = form.longitude;
    // this.title = form.title;
    // this.typeEventId = form.typeEventId;
    // this.description = form.description;
    // this.placeDescription = form.placeDescription;
    // this.startDate = form.startDate;
    // this.createdDate = form.createdDate;
    // this.duration = form.duration;
    // this.peopleCount = form.peopleCount;
    // this.isClosed = form.isClosed;
    // this.files = form.files;
    this.notifyListeners();
    // this = form.toJson();
  }

  addCategory(Category item) {
    this.event.eventTypes.add(item);
    notifyListeners();
  }

  removeCategory(String guid) {
    event.eventTypes =
        event.eventTypes.where((item) => item.id != guid).toList();
    notifyListeners();
  }

  void addFile(File file) {
    files.add(file);
    notifyListeners();
  }

  void removeFile(File file) {
    files.removeWhere((element) => element == file);
    notifyListeners();
  }

  void clear() {
    this.readyToFill = false;
    this.event = Event.empty();
    this.files.clear();
    this.notifyListeners();
  }
}
