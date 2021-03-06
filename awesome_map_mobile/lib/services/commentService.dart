import 'dart:convert';

import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/models/comment/comment.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_map_mobile/main.dart';

import 'authorizationService.dart';

class CommentService {
  Future<List<Comment>> getCommentsForProblem(String id) async {
    AppConfig config = await AppConfig.forEnvironment();
    return await getComments(config.apiUrl + "api/Comments?problemId=$id");
  }

  Future<List<Comment>> getCommentsForEvent(String id) async {
    AppConfig config = await AppConfig.forEnvironment();
    return await getComments(config.apiUrl + "api/Comments?eventId=$id");
  }

  Future<List<Comment>> getComments(String request) async {
    Map<String, String> headers = await GetIt.I
        .get<AuthorizationService>()
        .getHeaders({"Content-type": "application/json"});
    Response res =
        await http.get(request, headers: headers);
    List<dynamic> jsonModel = json.decode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201)
      return jsonModel.map<Comment>((x) => Comment.fromJson(x)).toList();
    throw Exception(res.body.toString());
  }

  Future<Comment> sendComment(Comment comment) async {
    AppConfig config = await AppConfig.forEnvironment();
    Map<String, String> headers = await GetIt.I
        .get<AuthorizationService>()
        .getHeaders({"Content-type": "application/json"});
    Map<String, dynamic> jsonEntity = comment.toJson();
    Response res = await http.post(config.apiUrl + "api/Comments",
        headers: headers, body: jsonEncode(jsonEntity));
    Map<String, dynamic> jsonModel = json.decode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201)
      return Comment.fromJson(jsonModel);
    throw Exception(res.body.toString());
  }
}
