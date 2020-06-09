import 'dart:io';

import 'package:awesome_map_mobile/account/provder/accountProvider.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:awesome_map_mobile/models/files/serverFile.dart';
import 'package:awesome_map_mobile/services/eventService.dart';
import 'package:awesome_map_mobile/services/fileService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventForm with ChangeNotifier {
  bool readyToFill = false;
  bool first = false;
  Event event = Event.empty();
  List<File> files = new List<File>();

  void setLatLon(LatLng position) {
    this.event.latitude = num.parse(position.latitude.toStringAsFixed(10));
    this.event.longitude = num.parse(position.longitude.toStringAsFixed(10));
    this.readyToFill = true;
    this.notifyListeners();
  }

  Future<bool> save() async {
      if (event.title.isEmpty ||
        event.description.isEmpty ||
        files.length == 0 ||
        event.startDate == null ||
        event.duration == null ||
        event.eventTypes.length == 0) {
      first = true;
      this.notifyListeners();
      return false;
    } else {
      first = false;
    }
    try {
      this.event = await GetIt.I.get<EventService>().save(this.event);
      ServerFile fileInfo = ServerFile.empty();
      fileInfo.eventId = this.event.id;
      for (File item in files) {
        fileInfo = await GetIt.I.get<FileService>().save(fileInfo, item);
        this.event.files.add(fileInfo);
      }
      await GetIt.I.get<AccountProvider>().addEvent(event.id);

      readyToFill = false;
      return true;
    } catch (e) {
      print(e.message.toString());
    }
    return false;
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
    this.first = false;
    this.notifyListeners();
  }
}
