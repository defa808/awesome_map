// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serverFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerFile _$ServerFileFromJson(Map<String, dynamic> json) {
  return ServerFile(
    json['id'] as String,
    json['name'] as String,
    (json['size'] as num)?.toDouble(),
    json['fileBody'] == null
        ? null
        : FileBody.fromJson(json['fileBody'] as Map<String, dynamic>),
    json['problemId'] as String,
    json['eventId'] as String,
  );
}

Map<String, dynamic> _$ServerFileToJson(ServerFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'size': instance.size,
      'fileBody': instance.fileBody,
      'problemId': instance.problemId,
      'eventId': instance.eventId,
    };
