import 'dart:io';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/files/serverFile.dart';
import 'package:json_annotation/json_annotation.dart';
part 'event.g.dart';

@JsonSerializable()
class Event {
  @JsonKey(required: true)
  String id;
  @JsonKey(required: true)
  double latitude;
  double longitude;
  @JsonKey(required: true)
  String title;
  @JsonKey(required: true)
  List<Category> eventTypes;
  String description;
  String placeDescription;
  DateTime startDate;
  DateTime createdDate;
  Duration duration;
  int peopleCount;
  List<ServerFile> files;
  bool isClosed;
  Event(
      this.id,
      this.latitude,
      this.longitude,
      this.title,
      this.eventTypes,
      this.description,
      this.placeDescription,
      this.startDate,
      this.createdDate,
      this.duration,
      this.peopleCount,
      this.isClosed,
      this.files);

  factory Event.empty() {
    return Event(
        "00000000-0000-0000-0000-000000000000",
        0,
        0,
        "",
        new List<Category>(),
        "",
        "",
        DateTime.now(),
        DateTime.now(),
        Duration(),
        0,
        false,
        new List<ServerFile>());
  }

  factory Event.fromJson(Map<String, dynamic> json) =>
      _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
