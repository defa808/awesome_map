import 'package:awesome_map_mobile/comments/provider/commentProvider.dart';
import 'package:awesome_map_mobile/models/comment/comment.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentInput extends StatefulWidget {
  const CommentInput(this.comment, {Key key}) : super(key: key);
  final Comment comment;

  @override
  _CommentInputState createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  TextEditingController textController = new TextEditingController();
  bool sending = false;
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: TextField(
              controller: textController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Введіть коментар..."),
              onChanged: (value) => widget.comment.text = value,
            ),
          ),
          IconButton(
              icon:
                  Icon(Icons.send, color: CustomTheme.of(context).accentColor),
              onPressed: () {
                if (sending) return;
                if (widget.comment.text != "" && widget.comment.text != null) {
                  if (sending) return;
                  setState(() {
                    sending = true;
                  });
                  context
                      .read<CommentProvider>()
                      .sendComment(widget.comment)
                      .then((res) {
                    if (res) {
                      textController.text = "";
                      widget.comment.text = "";
                      setState(() {
                        sending = false;
                      });
                    }
                  });
                }
              }),
        ],
      ),
    );
  }
}
