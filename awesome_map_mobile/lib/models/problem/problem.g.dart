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
    'problemTypes'
  ]);
  return Problem(
    json['id'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    json['title'] as String,
    (json['problemTypes'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['description'] as String,
    (json['files'] as List)
        ?.map((e) =>
            e == null ? null : ServerFile.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProblemToJson(Problem instance) => <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'title': instance.title,
      'problemTypes': instance.problemTypes,
      'description': instance.description,
      'files': instance.files,
    };
