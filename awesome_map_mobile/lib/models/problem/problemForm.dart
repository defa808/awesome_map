import 'dart:io';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProblemForm extends Problem with ChangeNotifier {
  bool readyToFill = false;

  void setLatLon(LatLng position) {
    this.latitude = num.parse(position.latitude.toStringAsFixed(10));
    this.longitude = num.parse(position.longitude.toStringAsFixed(10));
    this.readyToFill = true;
    this.notifyListeners();
  }

  ProblemForm(double latitude, double longitude, String title,
      int typeProblemId, String description, List<File> files)
      : super(latitude, longitude, title, typeProblemId, description, files);

  void save(ProblemForm form) {
    this.latitude = form.latitude;
    this.longitude = form.longitude;
    this.title = form.title;
    this.typeProblemId = form.typeProblemId;
    this.description = form.description;
    this.files = form.files;
    this.notifyListeners();
    // this = form.toJson();
  }

  void clear() {
    this.readyToFill = false;
    this.latitude = 0;
    this.longitude = 0;
    this.title = "";
    this.typeProblemId = -1;
    this.description = "";
    this.files = new List<File>();
    this.notifyListeners();
  }
}
