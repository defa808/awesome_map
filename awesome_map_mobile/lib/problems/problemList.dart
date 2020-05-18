import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/problems/problemItem.dart';
import 'package:awesome_map_mobile/problems/providers/problemMarkers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProblemList extends StatefulWidget {
  ProblemList({Key key}) : super(key: key);

  @override
  _ProblemListState createState() => _ProblemListState();
}

class _ProblemListState extends State<ProblemList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> problems = context
        .watch<ProblemMarkers>()
        .problems
        .map<Widget>((x) => ProblemItem(problem: x))
        .toList();

    return ListView(
      children: problems,
    );
  }
}
