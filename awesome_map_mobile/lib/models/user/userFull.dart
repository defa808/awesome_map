import 'package:awesome_map_mobile/models/comment/comment.dart';
import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:awesome_map_mobile/models/files/serverFile.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:json_annotation/json_annotation.dart';
part 'userFull.g.dart';

@JsonSerializable()
class UserFull {
  @JsonKey(required: true)
  String id;
  String userName;
  String email;
  ServerFile avatar;
  List<Problem> myProblems;
  List<Problem> observedProblems;
  List<Event> myEvents;
  List<Event> observedEvents;
  List<Comment> inbox;

  UserFull(this.id, this.email, this.userName, this.avatar, this.myProblems,
      this.observedProblems, this.myEvents, this.observedEvents, this.inbox);

  factory UserFull.empty() {
    return UserFull(
        "00000000-0000-0000-0000-000000000000",
        null,
        null,
        null,
        new List<Problem>(),
        new List<Problem>(),
        new List<Event>(),
        new List<Event>(),
        new List<Comment>());
  }

  factory UserFull.fromJson(Map<String, dynamic> json) =>
      _$UserFullFromJson(json);

  Map<String, dynamic> toJson() => _$UserFullToJson(this);
}
