import 'dart:math';

import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  CommentItem({Key key}) : super(key: key);

  List<String> messages = [
    "Вони винні так само, як і ті, хто через душевну слабкість, тобто через бажання уникнути страждань і болю відмовляється від виконання свого обов’язку. Якщо скористатися найпростішим прикладом, то хто з нас став би займатися якими б то не було тяжкими фізичними вправами, якщо б це не приносило з собою якоїсь користі?",
    "Так само як немає нікого, хто полюбивши, вважав за краще і зажадав би саме страждання тільки за те, що це страждання, а не тому, що інший раз виникають такі обставини, коли страждання і біль приносять якесь і чималу насолоду.",
    "Дійсно, ніхто не відкидає, не зневажає, не уникає насолод тільки через це."
  ];

  @override
  Widget build(BuildContext context) {
    num random = new Random().nextInt(2);

    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundImage: AssetImage("images/noavatar.png"),
      ),
      title: Text(random % 2 == 0 ? 'Адміністратор' : "Тарас Григорович"),
      subtitle: Row(
        children: <Widget>[
          Flexible(child: Text(messages[random])),
        ],
      ),
      trailing: Text("14:50", style: TextStyle(fontSize: 13)),
      onTap: () {
        print('horse');
      },
    );
  }
}
