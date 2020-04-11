import 'dart:io';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Problem {
  @JsonKey(required: true)
  double latitude;
  double longitude;
  @JsonKey(required: true)
  String title;
  @JsonKey(required: true)
  int typeProblemId;
  String description;
  List<File> files;
  Problem(this.latitude, this.longitude, this.title, this.typeProblemId,
      this.description,this.files);

}
