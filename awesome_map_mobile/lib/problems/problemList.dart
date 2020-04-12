import 'package:awesome_map_mobile/problems/problemItem.dart';
import 'package:flutter/material.dart';

class ProblemList extends StatefulWidget {
  ProblemList({Key key}) : super(key: key);

  @override
  _ProblemListState createState() => _ProblemListState();
}

class _ProblemListState extends State<ProblemList> {
  @override
  Widget build(BuildContext context) {
    Widget templateWidget = ProblemItem();

    return ListView(
        children: ListTile.divideTiles(
            context: context,
            tiles: List.generate(10, (i) => templateWidget)).toList());
  }
}
