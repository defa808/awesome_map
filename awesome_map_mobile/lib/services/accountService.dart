import 'dart:convert';

import 'package:awesome_map_mobile/env/config.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'authorizationService.dart';

class AccountService {
  subscribeOnProblem(String problemId) async {
    AppConfig config = await AppConfig.forEnvironment();
    Map<String, String> headers = await GetIt.I
        .get<AuthorizationService>()
        .getHeaders({"Content-type": "application/json"});
    Response res = await http.post(config.apiUrl + "api/Problems/Subscribe",
        headers: headers, body: jsonEncode(problemId));
    if (res.statusCode == 200 || res.statusCode == 201) return res.body == "true";
    throw Exception(res.body.toString());
  }

  unSubscribeOnProblem(String problemId) async {
      AppConfig config = await AppConfig.forEnvironment();
    Map<String, String> headers = await GetIt.I
        .get<AuthorizationService>()
        .getHeaders({"Content-type": "application/json"});
    Response res = await http.post(config.apiUrl + "api/Problems/Unsubscribe",
        headers: headers, body: jsonEncode(problemId));
    if (res.statusCode == 200 || res.statusCode == 201) return res.body == "true";
    throw Exception(res.body.toString());
  }

  subsribeOnEvent(String eventId) async {
      AppConfig config = await AppConfig.forEnvironment();
    Map<String, String> headers = await GetIt.I
        .get<AuthorizationService>()
        .getHeaders({"Content-type": "application/json"});
    Response res = await http.post(config.apiUrl + "api/Events/Subscribe",
        headers: headers, body: jsonEncode(eventId));
    if (res.statusCode == 200 || res.statusCode == 201) return res.body == "true";
    throw Exception(res.body.toString());
  }

  unSubscribeOnEvent(String eventId) async {
      AppConfig config = await AppConfig.forEnvironment();
    Map<String, String> headers = await GetIt.I
        .get<AuthorizationService>()
        .getHeaders({"Content-type": "application/json"});
    Response res = await http.post(config.apiUrl + "api/Events/Unsubscribe",
        headers: headers, body: jsonEncode(eventId));
    if (res.statusCode == 200 || res.statusCode == 201) return res.body == "true";
    throw Exception(res.body.toString());
  }
}
