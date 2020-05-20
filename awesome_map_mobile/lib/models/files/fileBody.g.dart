// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fileBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileBody _$FileBodyFromJson(Map<String, dynamic> json) {
  return FileBody(
    json['fileId'] as String,
    json['contentType'] as String,
  );
}

Map<String, dynamic> _$FileBodyToJson(FileBody instance) => <String, dynamic>{
      'fileId': instance.fileId,
      'contentType': instance.contentType,
    };
