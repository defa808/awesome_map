import 'dart:io';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Event {
  @JsonKey(required: true)
  double latitude;
  double longitude;
  @JsonKey(required: true)
  String title;
  @JsonKey(required: true)
  int typeEventId;
  String description;
  String placeDescription;
  DateTime startDate;
  DateTime createdDate;
  Duration duration;
  int peopleCount;
  List<File> files;
  bool isClosed;
  Event(this.latitude, this.longitude, this.title, this.typeEventId,
      this.description,
      this.placeDescription,
      this.startDate,
      this.createdDate,
      this.duration,
      this.peopleCount,
      this.isClosed,
      this.files);

}
