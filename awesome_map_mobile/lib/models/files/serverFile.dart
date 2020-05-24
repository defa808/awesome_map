import 'package:json_annotation/json_annotation.dart';
import 'fileBody.dart';
part 'serverFile.g.dart';

@JsonSerializable()
class ServerFile {
  String id;
  String name;
  double size;
  FileBody fileBody;
  String problemId;
  String eventId;
  String path;

  ServerFile(this.id, this.name, this.size, this.fileBody, this.problemId, this.eventId);

  factory ServerFile.empty() {
    return ServerFile("00000000-0000-0000-0000-000000000000", null, 0, null, null,null);
  }

  factory ServerFile.fromJson(Map<String, dynamic> json) =>
      _$ServerFileFromJson(json);

  Map<String, dynamic> toJson() => _$ServerFileToJson(this);
}
