import 'dart:convert';

import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/main.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ProblemService {
  // final AsyncMemoizer _memoizer = AsyncMemoizer();
// _memoizer.runOnce(() =>);
  Future<List<Category>> getCategories() async {
    AppConfig config = await AppConfig.forEnvironment();
    Map<String, String> headers = {"Content-type": "application/json"};
    headers["Authorization"] = "Bearer " + await storage.read(key: 'jwt');
    Response res =
        await http.get(config.apiUrl + "api/ProblemTypes", headers: headers);

    if (res.statusCode == 200 || res.statusCode == 201) {
      List<dynamic> categoriesJson = json.decode(res.body);
      return categoriesJson.map<Category>((x) => Category.fromJson(x)).toList();
    }
    throw Exception(res.body.toString());
  }

  Future<List<Problem>> getProblems() async {
    try {
      AppConfig config = await AppConfig.forEnvironment();
      Map<String, String> headers = Map<String, String>();
      headers["Authorization"] = "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6WyI0ZjA0YTRmNy1kOGU4LTQ2NGQtYjU2ZS0xM2EyMTcwYzRkZjMiLCJhZG1pbiJdLCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsInJvbGUiOiJBZG1pbiIsIm5iZiI6MTU5MDQzNDUxMSwiZXhwIjoxNTkwNTIwOTExLCJpYXQiOjE1OTA0MzQ1MTF9.iGAEgWBlGT9bbiPhbm7LVvW0v7aJCAxahrFZtyjOZ-xOEwDS6Gal7Ik7fGrprdUKhIHN1YcW6zno_DMm6bgWCg"; //+ await storage.read(key: 'jwt');
      headers["Content-type"] = "application/json";

      Response res =
          await http.get(config.apiUrl + "api/Problems", headers: headers);
      if (res.statusCode == 200 || res.statusCode == 201) {
        List<dynamic> jsonModel = json.decode(res.body);
        return jsonModel.map<Problem>((x) => Problem.fromJson(x)).toList();
      }
      throw new Exception(res.body.toString());
    } catch (e) {
      var t = e;
      print(e.toString());
    }
    return new List<Problem>();
  }

  Future<Problem> save(Problem problem) async {
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
