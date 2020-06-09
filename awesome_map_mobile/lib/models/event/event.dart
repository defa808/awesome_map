import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/comment/comment.dart';
import 'package:awesome_map_mobile/models/files/serverFile.dart';
import 'package:json_annotation/json_annotation.dart';
part 'event.g.dart';

@JsonSerializable()
class Event {
  @JsonKey(required: true)
  String id;
  @JsonKey(required: true)
  double latitude;
  @JsonKey(required: true)
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
  bool isClosed;
  int subscribersCount;
  List<ServerFile> files;
  List<Comment> comments;

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
      this.subscribersCount,
      this.files,
      this.comments);

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
        null,
        0,
        false,
        0,
        new List<ServerFile>(),
        new List<Comment>());
  }

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  addCategory(Category item) {
    this.eventTypes.add(item);
  }

  removeCategory(String guid) {
    this.eventTypes = this.eventTypes.where((item) => item.id != guid).toList();
  }
}
