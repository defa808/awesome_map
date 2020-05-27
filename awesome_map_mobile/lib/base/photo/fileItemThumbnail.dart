import 'dart:io';

import 'package:awesome_map_mobile/models/files/serverFile.dart';
import 'package:awesome_map_mobile/services/fileService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FileItemThumbnail extends StatefulWidget {
  const FileItemThumbnail({Key key, this.file, this.onTap}) : super(key: key);

  final ServerFile file;

  final Function(String path) onTap;

  @override
  _FileItemThumbnailState createState() => _FileItemThumbnailState();
}

class _FileItemThumbnailState extends State<FileItemThumbnail> {
  Future<File> getFile;

  @override
  void initState() {
    super.initState();
    getFile = executeFile();
  }

  Future<File> executeFile() async {
    return await GetIt.I.get<FileService>().getFile(widget.file);
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.file.id,
      child: FutureBuilder<File>(
        future: getFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Column(
                children: <Widget>[
                  const CircularProgressIndicator(),
                ],
              );
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: GestureDetector(
                        onTap: () =>
                          snapshot.data != null ?
                          widget.onTap(snapshot.data.parent.parent.path) : null,
                        child: 
                        snapshot.data != null ?
                        Image.file(snapshot.data, height: 100.0):Image.asset("images/noavatar.png")));
              }
          }
        },
      ),
    );
  }
}
