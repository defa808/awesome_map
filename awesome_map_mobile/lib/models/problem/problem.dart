import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/files/serverFile.dart';
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
  DateTime createDate;
  DateTime updateDate;

  String description;
  List<ServerFile> files;
  int subscribersCount;
  Problem(
      this.id,
      this.latitude,
      this.longitude,
      this.title,
      this.createDate,
      this.updateDate,
      this.description,
      this.problemTypes,
      this.files,
      this.subscribersCount);

  factory Problem.empty() {
    return Problem(
        "00000000-0000-0000-0000-000000000000",
        0,
        0,
        "",
        DateTime.now(),
        null,
        "",
        new List<Category>(),
        new List<ServerFile>(),
        0);
  }

  factory Problem.fromJson(Map<String, dynamic> json) =>
      _$ProblemFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemToJson(this);
}
