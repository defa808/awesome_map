import 'dart:convert';

import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Categories with ChangeNotifier {
  List<Category> categories = new List<Category>();
  String requestApiUrl;
  Categories(@required this.requestApiUrl);

  void tryLoad() async {
    if (categories.length > 0) return;
    AppConfig config = await AppConfig.forEnvironment();
    Response res = await http.get(config.apiUrl + requestApiUrl,
        headers: {"Content-type": "application/json"});
    List<dynamic> categoriesJson = json.decode(res.body);
    this.categories =
        categoriesJson.map<Category>((x) => Category.fromJson(x)).toList();
    this.notifyListeners();
  }
}
