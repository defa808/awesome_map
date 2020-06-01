import 'dart:io';
import 'dart:math';

import 'package:awesome_map_mobile/models/comment/comment.dart';
import 'package:awesome_map_mobile/services/fileService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class CommentItem extends StatefulWidget {
  CommentItem(this.comment, {Key key}) : super(key: key);
  Comment comment;

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  Future<File> getFile;

  @override
  void initState() {
    super.initState();
    getFile = executeFile();
  }

  Future<File> executeFile() async {
    if (widget.comment.userSender.avatar != null) {
      return await GetIt.I
          .get<FileService>()
          .getFile(widget.comment.userSender.avatar);
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: FutureBuilder<File>(
        future: executeFile(),
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
                    child: CircleAvatar(
                        backgroundImage: snapshot.data != null
                            ? AssetImage(snapshot.data.path)
                            : AssetImage("images/noavatar.png")));
              }
          }
        },
      ),
      title: Text(widget.comment.userSender?.userName ?? ""),
      subtitle: Row(
        children: <Widget>[
          Flexible(child: Text(widget.comment.text)),
        ],
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(DateFormat.Hm().format(widget.comment.timeSend),
              style: TextStyle(fontSize: 13)),
        ],
      ),
      onTap: () {
        print('horse');
      },
    );
  }
}
