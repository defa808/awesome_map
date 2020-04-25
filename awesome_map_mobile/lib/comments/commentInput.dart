import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';

class CommentInput extends StatelessWidget {
  const CommentInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 16,),
            Expanded(
              child: TextField(
                 keyboardType: TextInputType.multiline,
                  maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Введіть коментар..."),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send, color: CustomTheme.of(context).accentColor),
              onPressed: () {},
            ),
          ],
        ),
    );
  }
}
