import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/problems/problemItem.dart';
import 'package:awesome_map_mobile/problems/providers/problemMarkers.dart';
import 'package:awesome_map_mobile/services/problemService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProblemList extends StatefulWidget {
  ProblemList({Key key}) : super(key: key);

  @override
  _ProblemListState createState() => _ProblemListState();
}

class _ProblemListState extends State<ProblemList> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    try {
      await context.read<ProblemMarkers>().getProblems();
      _refreshController.refreshCompleted();
    } catch (e) {
      print(e.toString());
    }
  }

  void _onLoading() async {
    setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> problems = context
        .watch<ProblemMarkers>()
        .filteredProblems
        .map<Widget>((x) => ProblemItem(problem: x))
        .toList();

    return SmartRefresher(
      enablePullDown: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView(
        children: problems,
      ),
    );
  }
}
