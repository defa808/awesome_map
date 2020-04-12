import 'package:awesome_map_mobile/home/mapListButton.dart';
import 'package:awesome_map_mobile/problems/problemList.dart';
import 'package:awesome_map_mobile/problems/problemMap.dart';
import 'package:flutter/material.dart';

class ProblemHome extends StatefulWidget {
  ProblemHome({Key key}) : super(key: key);

  @override
  _ProblemHomeState createState() => _ProblemHomeState();
}

class _ProblemHomeState extends State<ProblemHome> {
  bool isShowList = false;
  @override
  void initState() {
    super.initState();
  }

  void showMap() {
    setState(() {
      isShowList = false;
    });
  }

  Widget mapListButton;

  @override
  Widget build(BuildContext context) {
    mapListButton = MapListButton(
      initialValue: isShowList ? 1 : 0,
      onListChange: () => setState(
        () {
          isShowList = true;
        },
      ),
      onMapChange: () => setState(() {
        isShowList = false;
      }),
    );

    return isShowList
        ? Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: mapListButton,
              ),
              Divider(),
              Expanded(child: ProblemList()),
            ],
          )
        : Stack(
            children: <Widget>[
              ProblemMap(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: mapListButton,
              )
            ],
          );
  }
}
