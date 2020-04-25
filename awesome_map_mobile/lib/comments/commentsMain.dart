import 'package:flutter/material.dart';

import 'commentInput.dart';
import 'commentsList.dart';

class CommentsMain extends StatelessWidget {
  const CommentsMain({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      Flexible(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16.0),
        child: CommentsList(),
      )),
      CommentInput(),
    ]);
  }
}
