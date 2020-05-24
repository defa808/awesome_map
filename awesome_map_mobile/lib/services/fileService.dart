import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/models/files/fileBody.dart';
import 'package:awesome_map_mobile/models/files/serverFile.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  static Future<ServerFile> save(ServerFile fileInfo, io.File file) async {
    try {
      AppConfig config = await AppConfig.forEnvironment();
      var request = http.MultipartRequest(
          "POST", Uri.parse(config.apiUrl + "api/ServerFiles"));
      //add text fields
      request.fields["serverFile"] = jsonEncode(fileInfo.toJson());
      //create multipart using filepath, string or bytes
      var pic = await http.MultipartFile.fromPath("files", file.path,
          filename: basename(file.path));
      //add multipart to request
      request.files.add(pic);
      var response = await request.send();
      var bodyBytes = await response.stream.toBytes();
      var bodyString = String.fromCharCodes(bodyBytes);

      ServerFile newServerFile = ServerFile.fromJson(jsonDecode(bodyString));
      await saveFileToTempDirectory(
          newServerFile.id, newServerFile.name, file.readAsBytesSync());

      return newServerFile;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<File> getFile(ServerFile serverFile) async {
    File file = await loadFile(serverFile.id, serverFile.name);
    if (file != null) serverFile.path = file.path;
    return file;
    // File file = await getExistFile(id);
    // if (file == null) file = await loadFile(id);
    // return file;
  }

  static Future<Uint8List> getFileBytes(String id) async {
    try {
      AppConfig config = await AppConfig.forEnvironment();

      Response response = await http.get(config.apiUrl + "api/FileBodies/$id");
      if (response.statusCode == 200 || response.statusCode == 201)
        return response.bodyBytes;
      throw Exception(response.body.toString());
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<File> getExistFile(String id) async {
    Directory dir = await _getLocalDir();
    List<FileSystemEntity> elements = dir.listSync();
    List<FileSystemEntity> files =
        elements.where((element) => basename(element.uri.path) == id).toList();
    return files.length > 0 ? File(files[0].path) : null;
  }

  static Future<File> loadFile(String id, String name) async {
    try {
      AppConfig config = await AppConfig.forEnvironment();

      Response response = await http.get(config.apiUrl + "api/FileBodies/$id");
      if (response.statusCode == 200 || response.statusCode == 201) {
        Uint8List result = base64.decode(response.body);
        // Uint8List resString = decode(response.bodyBytes);
        // var t = AsciiEncoder().convert(response.body);
        return await saveFileToTempDirectory(id, name, result);
      }
      throw Exception(response.body.toString());

      // _saveFileLocal(id, file);
      // return await getExistFile(id);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<io.File> saveFileToTempDirectory(
      String id, String name, Uint8List result) async {
    Directory dir = await _getLocalDir();
    Directory fileDirectory = Directory(dir.path + "/" + id);
    if (!fileDirectory.existsSync()) fileDirectory.createSync();
    File item = File(fileDirectory.path + "/" + name);
    if (item.existsSync()) item.deleteSync();
    item.createSync();
    item.writeAsBytesSync(result);
    return item;
  }

  static Future<io.Directory> _getLocalDir() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    final dirPath = '${path}/AwesomeMapImages';
    Directory dir = new Directory(dirPath);
    if (!dir.existsSync()) dir.create();
    return dir;
  }

  static String getType(String contentType) {
    switch (contentType) {
      case "image/jpeg":
        return "jpg";
      default:
        return "jpg";
    }
  }
}
