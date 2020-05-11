import 'package:json_annotation/json_annotation.dart';
part 'amIcon.g.dart';

@JsonSerializable()
class AMIcon{
  String id;
  int iconCode;
  String fontFamily;
  String fontPackage;

  AMIcon(this.id, this.iconCode,this.fontFamily, this.fontPackage);

factory AMIcon.fromJson(Map<String, dynamic> json) =>
      _$AMIconFromJson(json);

  Map<String, dynamic> toJson() => _$AMIconToJson(this);


}