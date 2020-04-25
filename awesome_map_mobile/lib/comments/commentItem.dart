import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundImage: AssetImage("images/noavatar.png"),
      ),
      title: Text('Адміністратор'),
      subtitle: Row(
        children: <Widget>[
          Flexible(
              child: Text(
                  "Товарищи! начало повседневной работы по формированию позиции позволяет выполнять важные задания по разработке дальнейших направлений развития.")),
        ],
      ),
      trailing: Text("14:50", style: TextStyle(fontSize: 13)),
      onTap: () {
        print('horse');
      },
    );
  }
}
