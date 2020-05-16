import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';
part 'fileBody.g.dart';

@JsonSerializable()
class FileBody {
  String fileId;
  @JsonKey(ignore: true)
  Uint8List body;
  FileBody(this.fileId, {this.body});

  factory FileBody.empty() {
    return FileBody(null);
  }

  factory FileBody.fromJson(Map<String, dynamic> json) =>
      _$FileBodyFromJson(json);

  Map<String, dynamic> toJson() => _$FileBodyToJson(this);
}
