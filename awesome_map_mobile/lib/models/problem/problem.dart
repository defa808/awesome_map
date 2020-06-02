import 'dart:io';

import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/comment/comment.dart';
import 'package:awesome_map_mobile/models/files/fileBody.dart';
import 'package:awesome_map_mobile/models/files/serverFile.dart';
import 'package:awesome_map_mobile/models/problem/problemStatus.dart';
import 'package:json_annotation/json_annotation.dart';
part 'problem.g.dart';

@JsonSerializable()
class Problem {
  @JsonKey(required: true)
  String id;
  @JsonKey(required: true)
  double latitude;
  @JsonKey(required: true)
  double longitude;
  @JsonKey(required: true)
  String title;
  @JsonKey(required: true)
  List<Category> problemTypes;
  @JsonKey(required: true)
  int status;
  @JsonKey(required: true)
  DateTime createDate;
  DateTime updateDate;
  List<Comment> comments;
  int commentsLength;

  String description;
  String ownerId;
  List<ServerFile> files;
  int subscribersCount;
  Problem(
      this.id,
      this.latitude,
      this.longitude,
      this.title,
      this.status,
      this.createDate,
      this.updateDate,
      this.description,
      this.ownerId,
      this.problemTypes,
      this.files,
      this.comments,
      this.commentsLength,
      this.subscribersCount);

  factory Problem.empty() {
    return Problem(
        "00000000-0000-0000-0000-000000000000",
        0,
        0,
        "",
        0,
        DateTime.now(),
        null,
        "",
        "00000000-0000-0000-0000-000000000000",
        new List<Category>(),
        new List<ServerFile>(),
        new List<Comment>(),
        0,
        0);
  }

  factory Problem.fromJson(Map<String, dynamic> json) =>
      _$ProblemFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemToJson(this);

  addCategory(Category item) {
    this.problemTypes.add(item);
  }

  removeCategory(String guid) {
    this.problemTypes =
        this.problemTypes.where((item) => item.id != guid).toList();
  }

  
}
