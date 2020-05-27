// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'id',
    'latitude',
    'longitude',
    'title',
    'eventTypes'
  ]);
  return Event(
    json['id'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    json['title'] as String,
    (json['eventTypes'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['description'] as String,
    json['placeDescription'] as String,
    json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String),
    json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
    json['duration'] == null
        ? null
        : Duration(microseconds: json['duration'] as int),
    json['peopleCount'] as int,
    json['isClosed'] as bool,
    json['subscribersCount'] as int,
    (json['files'] as List)
        ?.map((e) =>
            e == null ? null : ServerFile.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['comments'] as List)
        ?.map((e) =>
            e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'title': instance.title,
      'eventTypes': instance.eventTypes,
      'description': instance.description,
      'placeDescription': instance.placeDescription,
      'startDate': instance.startDate?.toIso8601String(),
      'createdDate': instance.createdDate?.toIso8601String(),
      'duration': instance.duration?.inMicroseconds,
      'peopleCount': instance.peopleCount,
      'isClosed': instance.isClosed,
      'subscribersCount': instance.subscribersCount,
      'files': instance.files,
      'comments': instance.comments,
    };
