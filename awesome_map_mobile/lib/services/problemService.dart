import 'dart:convert';

import 'package:async/async.dart';
import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ProblemService extends ChangeNotifier {
  final AsyncMemoizer _memoizer = AsyncMemoizer();

   Future<List<Category>> getCategories() async {
    AppConfig config = await AppConfig.forEnvironment();
    Response res = await _memoizer.runOnce(() => http.get(
        config.apiUrl + "api/ProblemTypes",
        headers: {"Content-type": "application/json"}));
    List<dynamic> categoriesJson = json.decode(res.body);
    return categoriesJson.map<Category>((x) => Category.fromJson(x)).toList();
  }
}
