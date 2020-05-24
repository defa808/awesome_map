import 'dart:convert';

import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ProblemService {
  // final AsyncMemoizer _memoizer = AsyncMemoizer();
// _memoizer.runOnce(() =>);
  static Future<List<Category>> getCategories() async {
    AppConfig config = await AppConfig.forEnvironment();
    Response res = await http.get(config.apiUrl + "api/ProblemTypes",
        headers: {"Content-type": "application/json"});
    if (res.statusCode == 200 || res.statusCode == 201) {
      List<dynamic> categoriesJson = json.decode(res.body);
      return categoriesJson.map<Category>((x) => Category.fromJson(x)).toList();
    }
    throw Exception(res.body.toString());
  }

  static Future<List<Problem>> getProblems() async {
    try {
      AppConfig config = await AppConfig.forEnvironment();
      Response res = await http.get(config.apiUrl + "api/Problems",
          headers: {"Content-type": "application/json"});
      if (res.statusCode == 200 || res.statusCode == 201) {
        List<dynamic> jsonModel = json.decode(res.body);
        return jsonModel.map<Problem>((x) => Problem.fromJson(x)).toList();
      }
      throw new Exception(res.body.toString());
    } catch (e) {
      print(e.toString());
    }
    return new List<Problem>();
  }

  static Future<Problem> save(Problem problem) async {
    try {
      AppConfig config = await AppConfig.forEnvironment();
      Map<String, dynamic> problemMap = problem.toJson();
      Response res = await http.post(config.apiUrl + "api/Problems",
          headers: {"Content-type": "application/json"},
          body: jsonEncode(problemMap));
      if (res.statusCode == 200 || res.statusCode == 201)
        return Problem.fromJson(jsonDecode(res.body));
      throw new Exception(res.body.toString());
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
