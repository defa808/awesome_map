import 'dart:convert';

import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/main.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/services/authorizationService.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ProblemService {
  Future<List<Category>> getCategories() async {
    AppConfig config = await AppConfig.forEnvironment();

    Map<String, String> headers = await GetIt.I
        .get<AuthorizationService>()
        .getHeaders({"Content-type": "application/json"});

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
      Map<String, String> headers = await GetIt.I
          .get<AuthorizationService>()
          .getHeaders({"Content-type": "application/json"});

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
       Map<String, String> headers = await GetIt.I
          .get<AuthorizationService>()
          .getHeaders({"Content-type": "application/json"});
      Response res = await http.post(config.apiUrl + "api/Problems",
          headers: headers,
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
