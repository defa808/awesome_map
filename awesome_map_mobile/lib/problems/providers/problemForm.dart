import 'dart:convert';
import 'dart:io';
import 'package:awesome_map_mobile/account/provder/accountProvider.dart';
import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/files/serverFile.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/services/fileService.dart';
import 'package:awesome_map_mobile/services/problemService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ProblemForm with ChangeNotifier {
  bool readyToFill = false;
  Problem problem = Problem.empty();
  List<File> files = new List<File>();
  void setLatLon(LatLng position) {
    problem.latitude = num.parse(position.latitude.toStringAsFixed(10));
    problem.longitude = num.parse(position.longitude.toStringAsFixed(10));
    this.readyToFill = true;
    this.notifyListeners();
  }

  Future<bool> save() async {
    try {
      this.problem =
          await GetIt.I.get<ProblemService>().save(this.problem);
      if (this.problem != null) {
        ServerFile fileInfo = ServerFile.empty();
        fileInfo.problemId = this.problem.id;
        for (File item in files) {
          fileInfo = await GetIt.I.get<FileService>().save(fileInfo, item);
          this.problem.files.add(fileInfo);
        }
        await GetIt.I.get<AccountProvider>().addProblem(problem.id);
        readyToFill = false;
        return true;
      }
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
    this.files.clear();
    this.notifyListeners();
  }

  void addFile(File file) {
    files.add(file);
    notifyListeners();
  }

  void removeFile(File file) {
    files.removeWhere((element) => element == file);
    notifyListeners();
  }
}
