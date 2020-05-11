import 'package:json_annotation/json_annotation.dart';
import 'fileBody.dart';
part 'serverFile.g.dart';

@JsonSerializable()
class ServerFile {
  String id;
  String name;
  double size;
  FileBody fileBody;

  ServerFile(this.id, this.name, this.size, this.fileBody);

  factory ServerFile.empty() {
    return ServerFile(null, null, 0, null);
  }

  factory ServerFile.fromJson(Map<String, dynamic> json) =>
      _$ServerFileFromJson(json);

  Map<String, dynamic> toJson() => _$ServerFileToJson(this);
}
