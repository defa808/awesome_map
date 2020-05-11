// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    id: json['id'] as String,
    name: json['name'] as String,
    icon: json['icon'] == null
        ? null
        : AMIcon.fromJson(json['icon'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
    };
