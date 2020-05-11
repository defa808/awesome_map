import 'dart:convert';
import 'dart:io';
import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/models/files/serverFile.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ProblemForm with ChangeNotifier {
  bool readyToFill = false;
  Problem problem = Problem.empty();
  void setLatLon(LatLng position) {
    problem.latitude = num.parse(position.latitude.toStringAsFixed(10));
    problem.longitude = num.parse(position.longitude.toStringAsFixed(10));
    this.readyToFill = true;
    this.notifyListeners();
  }

  Future<bool> save() async {
    try {
      AppConfig config = await AppConfig.forEnvironment();
      Response res = await http.post(config.apiUrl + "api/Problems",
          headers: {"Content-type": "application/json"},
          body: json.encode(problem.toJson()));
      return true;
    } catch (Exception) {}
    return false;
  }

  void clear() {
    this.readyToFill = false;
    this.problem = Problem.empty();
    this.notifyListeners();
  }
}
