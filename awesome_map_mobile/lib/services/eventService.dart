import 'dart:convert';

import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class EventService {
  // final AsyncMemoizer _memoizer = AsyncMemoizer();
// _memoizer.runOnce(() =>);
  Future<List<Category>> getCategories() async {
    AppConfig config = await AppConfig.forEnvironment();
    Response res = await http.get(config.apiUrl + "api/EventTypes",
        headers: {"Content-type": "application/json"});
    List<dynamic> categoriesJson = jsonDecode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201)
      return categoriesJson.map<Category>((x) => Category.fromJson(x)).toList();
    throw Exception(res.body.toString());
  }

  Future<List<Event>> getEvents() async {
    try {
      AppConfig config = await AppConfig.forEnvironment();
      Response res = await http.get(config.apiUrl + "api/Events",
          headers: {"Content-type": "application/json"});
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
      Response res = await http.post(config.apiUrl + "api/Events",
          headers: {"Content-type": "application/json"},
          body: jsonEncode(jsonMap));
      if (res.statusCode == 200 || res.statusCode == 201)
        return Event.fromJson(jsonDecode(res.body));
      throw Exception(res.body.toString());
    } catch (e) {
      print(e.message.toString());
    }
  }
}
