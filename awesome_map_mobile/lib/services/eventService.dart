import 'dart:convert';

import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'authorizationService.dart';

class EventService {
  // final AsyncMemoizer _memoizer = AsyncMemoizer();
// _memoizer.runOnce(() =>);
  Future<List<Category>> getCategories() async {
    AppConfig config = await AppConfig.forEnvironment();
    Map<String, String> headers = await GetIt.I
        .get<AuthorizationService>()
        .getHeaders({"Content-type": "application/json"});
    Response res =
        await http.get(config.apiUrl + "api/EventTypes", headers: headers);
    List<dynamic> categoriesJson = jsonDecode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201)
      return categoriesJson.map<Category>((x) => Category.fromJson(x)).toList();
    throw Exception(res.body.toString());
  }

  Future<List<Event>> getEvents() async {
    try {
      AppConfig config = await AppConfig.forEnvironment();
      Map<String, String> headers = await GetIt.I
          .get<AuthorizationService>()
          .getHeaders({"Content-type": "application/json"});
      Response res =
          await http.get(config.apiUrl + "api/Events", headers: headers);
      List<dynamic> jsonModel = json.decode(res.body);
      if (res.statusCode == 200 || res.statusCode == 201)
        return jsonModel.map<Event>((x) => Event.fromJson(x)).toList();
      throw Exception(res.body.toString());
    } catch (e) {
      print(e.toString());
    }
    return new List<Event>();
  }

  Future<Event> save(Event event) async {
    try {
      AppConfig config = await AppConfig.forEnvironment();
      Map<String, dynamic> jsonMap = event.toJson();
      Map<String, String> headers = await GetIt.I
          .get<AuthorizationService>()
          .getHeaders({"Content-type": "application/json"});
      Response res = await http.post(config.apiUrl + "api/Events",
          headers: headers, body: jsonEncode(jsonMap));
      if (res.statusCode == 200 || res.statusCode == 201)
        return Event.fromJson(jsonDecode(res.body));
      throw Exception(res.body.toString());
    } catch (e) {
      print(e.message.toString());
    }
  }

  Future<Event> update(Event event) async {
    try {
      AppConfig config = await AppConfig.forEnvironment();
      Map<String, dynamic> eventMap = event.toJson();
      Map<String, String> headers = await GetIt.I
          .get<AuthorizationService>()
          .getHeaders({"Content-type": "application/json"});
      Response res = await http.put(config.apiUrl + "api/Events/${event.id}",
          headers: headers, body: jsonEncode(eventMap));
      if (res.statusCode == 200 || res.statusCode == 201)
        return Event.fromJson(jsonDecode(res.body));
      throw new Exception(res.body.toString());
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
