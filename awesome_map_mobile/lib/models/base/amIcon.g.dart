// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amIcon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AMIcon _$AMIconFromJson(Map<String, dynamic> json) {
  return AMIcon(
    json['id'] as String,
    json['iconCode'] as int,
    json['fontFamily'] as String,
    json['fontPackage'] as String,
  );
}

Map<String, dynamic> _$AMIconToJson(AMIcon instance) => <String, dynamic>{
      'id': instance.id,
      'iconCode': instance.iconCode,
      'fontFamily': instance.fontFamily,
      'fontPackage': instance.fontPackage,
    };
