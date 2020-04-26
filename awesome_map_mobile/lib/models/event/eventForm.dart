import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'event.dart';

class EventForm extends Event with ChangeNotifier {
  bool readyToFill = false;

  void setLatLon(LatLng position) {
    this.latitude = num.parse(position.latitude.toStringAsFixed(10));
    this.longitude = num.parse(position.longitude.toStringAsFixed(10));
    this.readyToFill = true;
    this.notifyListeners();
  }

  EventForm(
    double latitude,
    double longitude,
    String title,
    int typeProblemId,
    String description,
    List<File> files,
    String placeDescription,
    DateTime startDate,
    DateTime createdDate,
    Duration duration,
    int peopleCount,
    bool isClosed,
  ) : super(
            latitude,
            longitude,
            title,
            typeProblemId,
            description,
            placeDescription,
            startDate,
            createdDate,
            duration,
            peopleCount,
            isClosed,
            files);

  factory EventForm.empty(){
    return EventForm(0, 0, "", 0, "", new List<File>(), "",
      DateTime.now(), DateTime.now(), Duration.zero, 0, false);
  }

  void save(EventForm form) {
    this.latitude = form.latitude;
    this.longitude = form.longitude;
    this.title = form.title;
    this.typeEventId = form.typeEventId;
    this.description = form.description;
    this.placeDescription = form.placeDescription;
    this.startDate = form.startDate;
    this.createdDate = form.createdDate;
    this.duration = form.duration;
    this.peopleCount = form.peopleCount;
    this.isClosed = form.isClosed;
    this.files = form.files;
    this.notifyListeners();
    // this = form.toJson();
  }

  void clear() {
    this.readyToFill = false;
    this.latitude = 0;
    this.longitude = 0;
    this.title = "";
    this.description = "";
    this.files = new List<File>();
    this.placeDescription = "";
    this.startDate = DateTime.now();
    this.createdDate = DateTime.now();
    this.duration = Duration.zero;
    this.peopleCount = 0;
    this.isClosed = false;
    this.notifyListeners();
  }
}
