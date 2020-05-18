import 'dart:convert';
import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/services/problemService.dart';
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
      this.problem = await ProblemService.save(this.problem);
      readyToFill = false;
      return true;
    } catch (e) {
      var exception = e;
    }
    return false;
  }

  addCategory(Category item) {
    this.problem.problemTypes.add(item);
    notifyListeners();
  }

  removeCategory(String guid) {
    problem.problemTypes =
        problem.problemTypes.where((item) => item.id != guid).toList();
    notifyListeners();
  }

  void clear() {
    this.readyToFill = false;
    this.problem = Problem.empty();
    this.notifyListeners();
  }
}
