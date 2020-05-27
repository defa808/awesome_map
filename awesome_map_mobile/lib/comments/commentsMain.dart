import 'package:awesome_map_mobile/models/comment/comment.dart';
import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/services/commentService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'commentInput.dart';
import 'commentsList.dart';
import 'provider/commentProvider.dart';

class CommentsMain extends StatefulWidget {
  CommentsMain({Key key, this.problem, this.event}) : super(key: key);
  final Problem problem;
  final Event event;

  @override
  _CommentsMainState createState() => _CommentsMainState();
}

class _CommentsMainState extends State<CommentsMain> {
  final Comment comment = Comment.empty();

  Future<List<Comment>> getComments;

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      comment.eventId = widget.event?.id;
      getComments =
          context.read<CommentProvider>().getCommentsForEvent(widget.event.id);
    }
    if (widget.problem != null) {
      comment.problemId = widget.problem?.id;
      getComments = context
          .read<CommentProvider>()
          .getCommentsForProblem(widget.problem.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(
      builder: (BuildContext context, CommentProvider consumerProvider,
          Widget child) {
        return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Flexible(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FutureBuilder<List<Comment>>(
                future: getComments,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Comment>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const CircularProgressIndicator(),
                          ),
                        ],
                      );
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return CommentsList(consumerProvider.getComments(
                            widget.event?.id ?? widget.problem?.id));
                      }
                  }
                }),
          )),
          CommentInput(comment),
        ]);
      },
    );
  }
}
