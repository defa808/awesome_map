import 'package:awesome_map_mobile/models/files/serverFile.dart';
import 'package:json_annotation/json_annotation.dart';
part 'userLight.g.dart';

@JsonSerializable()
class UserLight {
  @JsonKey(required: true)
  String id;
  String userName;
  String email;
  ServerFile avatar;

  UserLight(this.id, this.email, this.userName, this.avatar);

  factory UserLight.empty() {
    return UserLight("00000000-0000-0000-0000-000000000000", null, null, null);
  }

  factory UserLight.fromJson(Map<String, dynamic> json) => _$UserLightFromJson(json);

  Map<String, dynamic> toJson() => _$UserLightToJson(this);
}
