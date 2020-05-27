import 'dart:convert';

import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/models/user/user.dart';
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

  static Future<User> getInfo(String email) async {
    try {
      AppConfig config = await AppConfig.forEnvironment();
      Map<String, dynamic> jsonMap = {"email": email};
      Map<String, String> headers = {"Content-type": "application/json"};
      headers["Authorization"] = "Bearer " + await storage.read(key: 'jwt');
      Response res = await http.post(config.apiUrl + "api/Users/Info",
          headers: headers,
          body: json.encode(jsonMap));
      if (res.statusCode == 200 || res.statusCode == 201)
        return User.fromJson(jsonDecode(res.body));
      throw Exception(res.body.toString());
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
