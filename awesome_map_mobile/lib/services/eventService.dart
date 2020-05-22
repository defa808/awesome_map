import 'dart:convert';

import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class EventService {
  // final AsyncMemoizer _memoizer = AsyncMemoizer();
// _memoizer.runOnce(() =>);
  static Future<List<Category>> getCategories() async {
    AppConfig config = await AppConfig.forEnvironment();
    Response res = await http.get(config.apiUrl + "api/EventTypes",
        headers: {"Content-type": "application/json"});
    List<dynamic> categoriesJson = jsonDecode(res.body);
    return categoriesJson.map<Category>((x) => Category.fromJson(x)).toList();
  }

  static Future<List<Event>> getEvents() async {
    try{
    AppConfig config = await AppConfig.forEnvironment();
    Response res = await http.get(config.apiUrl + "api/Events",
        headers: {"Content-type": "application/json"});
    List<dynamic> jsonModel = json.decode(res.body);
    
    return jsonModel.map<Event>((x) => Event.fromJson(x)).toList();
    }catch(e){
      print(e.toString());
    }
  }

  static Future<Event> save(Event event) async {
    AppConfig config = await AppConfig.forEnvironment();
    Map<String, dynamic> problemMap = event.toJson();
    Response res = await http.post(config.apiUrl + "api/Events",
        headers: {"Content-type": "application/json"},
        body: jsonEncode(problemMap));
    return Event.fromJson(jsonDecode(res.body));
  }
}