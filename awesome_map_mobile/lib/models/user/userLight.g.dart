// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userLight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLight _$UserLightFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id']);
  return UserLight(
    json['id'] as String,
    json['email'] as String,
    json['userName'] as String,
    json['avatar'] == null
        ? null
        : ServerFile.fromJson(json['avatar'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserLightToJson(UserLight instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'avatar': instance.avatar,
    };
