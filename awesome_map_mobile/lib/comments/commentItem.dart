import 'dart:math';

import 'package:awesome_map_mobile/models/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentItem extends StatelessWidget {
  CommentItem(this.comment, {Key key}) : super(key: key);
  Comment comment;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundImage: AssetImage("images/noavatar.png"),
      ),
      title: Text(comment.userSender?.userName ?? ""),
      subtitle: Row(
        children: <Widget>[
          Flexible(child: Text(comment.text)),
        ],
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(DateFormat.Hm().format(comment.timeSend),
              style: TextStyle(fontSize: 13)),
        ],
      ),
      onTap: () {
        print('horse');
      },
    );
  }
}
