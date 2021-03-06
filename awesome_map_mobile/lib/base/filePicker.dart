import 'dart:io';

import 'package:awesome_map_mobile/problems/providers/problemForm.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FilePicker extends StatefulWidget {
  const FilePicker({Key key, this.addFile, this.removeFile, this.files, this.first = false, this.validate = true})
      : super(key: key);
  final List<File> files;
  final void Function(File) addFile;
  final void Function(File) removeFile;
  final bool first;
  final bool validate;
  @override
  _FilePickerState createState() => _FilePickerState();
}

class _FilePickerState extends State<FilePicker> {
  dynamic _pickImageError;
  String _retrieveDataError;

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      widget.addFile(await ImagePicker.pickImage(
          source: source, maxWidth: null, maxHeight: null, imageQuality: null));
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      widget.addFile(response.file);
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  List<Widget> _previewImages() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return [retrieveError];
    }

    List<Widget> fileInfos = List<Widget>();
    for (var fileItem in widget.files)
      if (fileItem != null) {
        fileInfos.add(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.file(
              fileItem,
              fit: BoxFit.scaleDown,
              height: 100,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "(" + filesize(fileItem.lengthSync(), 2) + ")",
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  color: Color.fromRGBO(77, 77, 77, 0.8),
                  onPressed: () {
                    widget.removeFile(fileItem);
                  },
                ),
              ],
            )
          ],
        ));
        // Image.file(_imageFile);
      } else if (_pickImageError != null) {
        fileInfos.add(Text(
          'Ошибка завантаження файлу: $_pickImageError',
          textAlign: TextAlign.center,
        ));
      } else {
        fileInfos.add(const Text(
          'Завантажте файл.',
          textAlign: TextAlign.center,
        ));
      }
    return fileInfos;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Platform.isAndroid
            ? FutureBuilder<void>(
                future: retrieveLostData(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    case ConnectionState.done:
                      return Wrap(
                        children: _previewImages(),
                      );

                    default:
                      if (snapshot.hasError) {
                        return Text(
                          'Pick image/video error: ${snapshot.error}}',
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return const Text(
                          'You have not yet picked an image.',
                          textAlign: TextAlign.center,
                        );
                      }
                  }
                },
              )
            : _previewImages(),
        RaisedButton.icon(
          textColor: Color.fromRGBO(77, 77, 77, 0.8),
          label: Text("Додати зображення"),
          icon: Icon(Icons.file_upload),
          elevation: 0.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          onPressed: () {
            _onImageButtonPressed(ImageSource.gallery, context: context);
          },
        ),
        if(widget.first && !widget.validate)
        Text("Додавання файлу обов'язкове", style: TextStyle(color:Colors.red),)
      ],
    );
  }
}
