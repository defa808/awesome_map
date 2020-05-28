import 'dart:convert';

import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/models/user/userFull.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class AuthorizationService {
  static Future<String> login(String email, String password) async {
    try {
      AppConfig config = await AppConfig.forEnvironment();
      Map<String, dynamic> jsonMap = {"email": email, "password": password};
      Response res = await http.post(config.apiUrl + "api/Users/Login",
          headers: {"Content-type": "application/json"},
          body: json.encode(jsonMap));
      if (res.statusCode == 200 || res.statusCode == 201) return res.body;
      throw Exception(res.body.toString());
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<UserFull> getInfo() async {
    try {
      AppConfig config = await AppConfig.forEnvironment();
      Map<String, String> headers = await GetIt.I
          .get<AuthorizationService>()
          .getHeaders({"Content-type": "application/json"});
      Response res = await http.post(
        config.apiUrl + "api/Users/Info",
        headers: headers,
      );
      if (res.statusCode == 200 || res.statusCode == 201)
        return UserFull.fromJson(jsonDecode(res.body));
      throw Exception(res.body.toString());
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static register(String email, String password) async {
    try {
      AppConfig config = await AppConfig.forEnvironment();
      Map<String, dynamic> jsonMap = {"email": email, "password": password};
      Response res = await http.post(config.apiUrl + "api/Users/Register",
          headers: {"Content-type": "application/json"},
          body: json.encode(jsonMap));
      if (res.statusCode == 200 || res.statusCode == 201) return res.body;
      throw Exception(res.body.toString());
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<bool> logOut() async {
    try {
      AppConfig config = await AppConfig.forEnvironment();
      Map<String, String> headers = await GetIt.I
          .get<AuthorizationService>()
          .getHeaders({"Content-type": "application/json"});
      Response res = await http.post(
        config.apiUrl + "api/Users/LogOut",
        headers: headers,
      );
      if (res.statusCode == 200 || res.statusCode == 201)
        return res.body == "true";
      throw Exception(res.body.toString());
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  getHeaders(Map<String, String> headers) async {
    String jwt = await storage.read(key: 'jwt');
    if (jwt != null) {
      headers["Authorization"] = "Bearer " + jwt;
      return headers;
    }
    String oauth = await storage.read(key: 'oauth');
    if (oauth != null) headers["Authorization"] = "Bearer " + oauth;
    return headers;
  }
}
