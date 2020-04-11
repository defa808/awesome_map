import 'package:awesome_map_mobile/home/mapListButton.dart';
import 'package:awesome_map_mobile/problems/problemFilter.dart';
import 'package:awesome_map_mobile/problems/problemList.dart';
import 'package:awesome_map_mobile/problems/problemMap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    // config.setSettings(
    //     title: Text('Проблеми'),
    //     actions: <Widget>[ProblemFilter()],
    //     floatingButton: null);

    return Stack(
      children: <Widget>[
        isShowList ? ProblemList() : ProblemMap(),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: MapListButton(
            onListChange: () => setState(
              () {
                isShowList = true;
              },
            ),
            onMapChange: () => setState(() {
              isShowList = false;
            }),
          ),
        ),
      ],
    );
  }
}
