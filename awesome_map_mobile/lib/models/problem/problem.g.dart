// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Problem _$ProblemFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['latitude', 'longitude', 'title', 'typeProblems']);
  return Problem(
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    json['title'] as String,
    (json['typeProblems'] as List)
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
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'title': instance.title,
      'typeProblems': instance.typeProblems,
      'description': instance.description,
      'files': instance.files,
    };
