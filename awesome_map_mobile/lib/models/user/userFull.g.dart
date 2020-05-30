// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userFull.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFull _$UserFullFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id']);
  return UserFull(
    json['id'] as String,
    json['email'] as String,
    json['userName'] as String,
    json['avatar'] == null
        ? null
        : ServerFile.fromJson(json['avatar'] as Map<String, dynamic>),
    (json['myProblemIds'] as List)?.map((e) => e as String)?.toList(),
    (json['observedProblemIds'] as List)?.map((e) => e as String)?.toList(),
    (json['myEventIds'] as List)?.map((e) => e as String)?.toList(),
    (json['observedEventIds'] as List)?.map((e) => e as String)?.toList(),
    (json['inbox'] as List)
        ?.map((e) =>
            e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserFullToJson(UserFull instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'avatar': instance.avatar,
      'myProblemIds': instance.myProblemIds,
      'observedProblemIds': instance.observedProblemIds,
      'myEventIds': instance.myEventIds,
      'observedEventIds': instance.observedEventIds,
      'inbox': instance.inbox,
    };
