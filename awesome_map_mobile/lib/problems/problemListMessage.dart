import 'package:awesome_map_mobile/account/provder/accountProvider.dart';
import 'package:awesome_map_mobile/problems/problemItem.dart';
import 'package:awesome_map_mobile/problems/providers/problemMarkers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProblemListMessage extends StatefulWidget {
  ProblemListMessage({Key key}) : super(key: key);

  @override
  _ProblemListMessageState createState() => _ProblemListMessageState();
}

class _ProblemListMessageState extends State<ProblemListMessage> {
  @override
  Widget build(BuildContext context) {
    // Widget templateWidget =  ListTile(
    //     leading: CircleAvatar(
    //       backgroundImage: AssetImage("images/noavatar.png"),
    //     ),
    //     title: Text('Horse'),
    //     subtitle: Text('A strong animal'),
    //     trailing: Column(
    //       crossAxisAlignment: CrossAxisAlignment.end,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         SizedBox(height: 8),
    //         Text("14:50", style: TextStyle(fontSize: 13)),
    //         Container(
    //             decoration:
    //                 BoxDecoration(shape: BoxShape.circle,border: Border.all(width:8, color: Colors.lightBlue), color: Colors.lightBlue),
    //             child: Text("8", style:TextStyle(fontSize: 13)))
    //       ],
    //     ),
    //     onTap: () {
    //       print('horse');
    //     },
    //   );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Проблеми'),
          centerTitle: true,
        ),
        body: Consumer<AccountProvider>(
          builder:
              (BuildContext context, AccountProvider account, Widget child) {
            return account.userInfo.observedProblemIds.length > 0
                ? ListView(
                    children: account.userInfo.observedProblemIds
                        .map((e) => 
                        ProblemItem(
                              problem: context.watch<ProblemMarkers>().getProblemDetails(e),
                              beforeShowMap: () {
                                Navigator.pop(context, true);
                                Navigator.pushReplacementNamed(context, '/home',
                                    arguments: 0);
                              },
                            ))
                        .toList(),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Список ваших проблем пустий.",
                            style: TextStyle(fontSize: 20)),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                            "Підпишіться до будь-якого запису з мапи або створіть свій.",
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  );
          },
        ));
  }
}
