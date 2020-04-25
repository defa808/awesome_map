import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      isThreeLine: true,
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
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text("14:50", style: TextStyle(fontSize: 13)),
          Icon(Icons.done_all),
        ],
      ),
      onTap: () {
        print('horse');
      },
    );
  }
}
