import 'package:awesome_map_mobile/models/files/serverFile.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(required: true)
  String id;
  String userName;
  String email;
  ServerFile avatar;

  User(this.id, this.email, this.userName, this.avatar);

  factory User.empty() {
    return User("00000000-0000-0000-0000-000000000000", null, null, null);
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
