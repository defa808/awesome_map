import 'package:awesome_map_mobile/comments/commentItem.dart';
import 'package:awesome_map_mobile/comments/provider/commentProvider.dart';
import 'package:awesome_map_mobile/models/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentsList extends StatefulWidget {
  CommentsList(this.commentsEntity, {Key key}) : super(key: key);
  List<Comment> commentsEntity = new List<Comment>();

  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // _getMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate;
    return ListView.builder(
        itemCount: widget.commentsEntity.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == widget.commentsEntity.length) {
            return _buildProgressIndicator();
          } else {
            DateTime dateTime = widget.commentsEntity[index].timeSend;
            if (currentDate == null ||
                currentDate.year != dateTime.year ||
                currentDate.month != dateTime.month ||
                currentDate.day != dateTime.day) {
              currentDate = widget.commentsEntity[index].timeSend;
              return Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          DateFormat.yMd().format(currentDate),
                        )
                      ]),
                ),
                CommentItem(widget.commentsEntity[index])
              ]);
            }
            currentDate = widget.commentsEntity[index].timeSend;
            return CommentItem(widget.commentsEntity[index]);
          }
        });
    // children: ListTile.divideTiles(
    //     context: context,
    //     tiles: List.generate(10, (i) => templateWidget)).toList());
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  // void _getMoreData() {
  //    if (!isPerformingRequest) {
  //     setState(() => isPerformingRequest = true);
  //     List<int> newEntries = await context.read<CommentProvider>().get(); //returns empty list
  //     if (newEntries.isEmpty) {
  //       double edge = 50.0;
  //       double offsetFromBottom = _scrollController.position.maxScrollExtent -
  //           _scrollController.position.pixels;
  //       if (offsetFromBottom < edge) {
  //         _scrollController.animateTo(
  //             _scrollController.offset - (edge - offsetFromBottom),
  //             duration: new Duration(milliseconds: 500),
  //             curve: Curves.easeOut);
  //       }
  //     }
  //     setState(() {
  //       items.addAll(newEntries);
  //       isPerformingRequest = false;
  //     });
  //   }
  // }
}
