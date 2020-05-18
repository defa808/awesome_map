import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'amIcon.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {
  String id;
  String name;
  AMIcon icon;
  Category(this.id, this.name, this.icon);

factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

}