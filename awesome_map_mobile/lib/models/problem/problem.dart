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
  
  String description;
  List<ServerFile> files;
  Problem(this.id,this.latitude, this.longitude, this.title, this.problemTypes,
      this.description,this.files);

  factory Problem.empty() {
    return Problem(null,0, 0, "", new List<Category>(), "", new List<ServerFile>());
  }

  factory Problem.fromJson(Map<String, dynamic> json) =>
      _$ProblemFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemToJson(this);
}
