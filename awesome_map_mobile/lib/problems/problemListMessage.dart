import 'package:flutter/material.dart';

class ProblemListMessage extends StatefulWidget {
  ProblemListMessage({Key key}) : super(key: key);

  @override
  _ProblemListMessageState createState() => _ProblemListMessageState();
}

class _ProblemListMessageState extends State<ProblemListMessage> {
  @override
  Widget build(BuildContext context) {

    Widget templateWidget =  ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage("images/noavatar.png"),
        ),
        title: Text('Horse'),
        subtitle: Text('A strong animal'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 8),
            Text("14:50", style: TextStyle(fontSize: 13)),
            Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle,border: Border.all(width:8, color: Colors.lightBlue), color: Colors.lightBlue),
                child: Text("8", style:TextStyle(fontSize: 13)))
          ],
        ),
        onTap: () {
          print('horse');
        },
      );

    return Scaffold(
       appBar: AppBar(
        title: const Text('Проблеми'),
        centerTitle: true,
      ),
        body: ListView(
            children: ListTile.divideTiles(context: context, tiles: 
              List.generate(10, (i) => templateWidget)).toList()));
  }
}
