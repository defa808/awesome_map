import 'dart:convert';

import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ProblemService  {

  // final AsyncMemoizer _memoizer = AsyncMemoizer();
// _memoizer.runOnce(() =>);
  static Future<List<Category>> getCategories() async {
    AppConfig config = await AppConfig.forEnvironment();
    Response res = await http.get(config.apiUrl + "api/ProblemTypes",
        headers: {"Content-type": "application/json"});
    List<dynamic> categoriesJson = json.decode(res.body);
      return  categoriesJson.map<Category>((x) => Category.fromJson(x)).toList();
  }

  static Future<List<Problem>> getProblems() async {
 AppConfig config = await AppConfig.forEnvironment();
    Response res = await http.get(config.apiUrl + "api/Problems",
        headers: {"Content-type": "application/json"});
    List<dynamic> jsonModel = json.decode(res.body);
    // categories =
      return  jsonModel.map<Problem>((x) => Problem.fromJson(x)).toList();
  }
}
