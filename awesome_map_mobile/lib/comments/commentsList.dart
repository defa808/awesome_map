import 'package:awesome_map_mobile/comments/commentItem.dart';
import 'package:flutter/material.dart';

class CommentsList extends StatelessWidget {
  CommentsList({Key key}) : super(key: key);
  final Widget templateWidget = CommentItem();

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: ListTile.divideTiles(
            context: context,
            tiles: List.generate(10, (i) => templateWidget)).toList());
  }
}
