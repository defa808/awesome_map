import 'package:awesome_map_mobile/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment.g.dart';

@JsonSerializable()
class Comment {
  @JsonKey(required: true)
  String id;
  String problemId;
  String eventId;
  String text;
  DateTime timeSend;
  String userId;
  User userSender;

  Comment(this.id, this.problemId, this.eventId, this.userId, this.text,
      this.timeSend, this.userSender);

  factory Comment.empty() {
    return Comment(
        "00000000-0000-0000-0000-000000000000",
        null,
        null,
        null,
        "",
        DateTime.now(),
        null);
  }

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
