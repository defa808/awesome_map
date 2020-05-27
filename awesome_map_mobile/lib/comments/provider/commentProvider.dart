import 'dart:core';

import 'package:awesome_map_mobile/models/comment/comment.dart';
import 'package:awesome_map_mobile/services/commentService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CommentProvider extends ChangeNotifier {
  Map<String, List<Comment>> commentsEntity = {};

  Future<List<Comment>> getCommentsForProblem(String id) async {
    List<Comment> comments =
        (await GetIt.I.get<CommentService>().getCommentsForProblem(id));
    commentsEntity[id] = comments;
    notifyListeners();
  }

  Future<List<Comment>> getCommentsForEvent(String id) async {
    List<Comment> comments =
        await GetIt.I.get<CommentService>().getCommentsForEvent(id);
    commentsEntity[id] = comments;
    notifyListeners();
  }

  List<Comment> getComments(String entityId) {
    if (!commentsEntity.containsKey(entityId))
      commentsEntity[entityId] = new List<Comment>();
    return commentsEntity[entityId]; //check if it works
  }

  Future<bool> sendComment(Comment comment) async {
    try {
      Comment newComment =
          await GetIt.I.get<CommentService>().sendComment(comment);
      if (commentsEntity.containsKey(newComment.problemId))
        commentsEntity[newComment.problemId].add(newComment);
      if (commentsEntity.containsKey(newComment.eventId))
        commentsEntity[newComment.eventId].add(newComment);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
