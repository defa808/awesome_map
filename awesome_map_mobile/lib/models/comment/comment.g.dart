// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id']);
  return Comment(
    json['id'] as String,
    json['problemId'] as String,
    json['eventId'] as String,
    json['userId'] as String,
    json['text'] as String,
    json['timeSend'] == null
        ? null
        : DateTime.parse(json['timeSend'] as String),
    json['userSender'] == null
        ? null
        : UserLight.fromJson(json['userSender'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'problemId': instance.problemId,
      'eventId': instance.eventId,
      'text': instance.text,
      'timeSend': instance.timeSend?.toIso8601String(),
      'userId': instance.userId,
      'userSender': instance.userSender,
    };
