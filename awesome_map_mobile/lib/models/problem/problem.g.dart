// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Problem _$ProblemFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'id',
    'latitude',
    'longitude',
    'title',
    'problemTypes',
    'status',
    'createDate'
  ]);
  return Problem(
    json['id'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    json['title'] as String,
    json['status'] as int,
    json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
    json['updateDate'] == null
        ? null
        : DateTime.parse(json['updateDate'] as String),
    json['description'] as String,
    (json['problemTypes'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['files'] as List)
        ?.map((e) =>
            e == null ? null : ServerFile.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['subscribersCount'] as int,
  );
}

Map<String, dynamic> _$ProblemToJson(Problem instance) => <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'title': instance.title,
      'problemTypes': instance.problemTypes,
      'status': instance.status,
      'createDate': instance.createDate?.toIso8601String(),
      'updateDate': instance.updateDate?.toIso8601String(),
      'description': instance.description,
      'files': instance.files,
      'subscribersCount': instance.subscribersCount,
    };
