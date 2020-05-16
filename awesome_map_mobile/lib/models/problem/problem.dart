import 'package:awesome_map_mobile/models/files/serverFile.dart';
import 'package:json_annotation/json_annotation.dart';
part 'problem.g.dart';

@JsonSerializable()
class Problem {
  @JsonKey(required: true)
  double latitude;
  @JsonKey(required: true)
  double longitude;
  @JsonKey(required: true)
  String title;
  @JsonKey(required: true)
  int typeProblemId;
  String description;
  List<ServerFile> files;
  Problem(this.latitude, this.longitude, this.title, this.typeProblemId,
      this.description,this.files);

  factory Problem.empty() {
    return Problem(0, 0, "", -1, "", new List<ServerFile>());
  }

  factory Problem.fromJson(Map<String, dynamic> json) =>
      _$ProblemFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemToJson(this);
}
