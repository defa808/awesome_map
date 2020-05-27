import 'package:awesome_map_mobile/base/title.dart';
import 'package:awesome_map_mobile/comments/commentsMain.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/problems/problemDetailsContent.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';

class ProblemDetails extends StatefulWidget {
  ProblemDetails({Key key}) : super(key: key);
  @override
  _ProblemDetailsState createState() => _ProblemDetailsState();
}

class _ProblemDetailsState extends State<ProblemDetails> {
  @override
  Widget build(BuildContext context) {
    Problem problem = ModalRoute.of(context).settings.arguments;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Детальніше"),
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Header(text: problem.title),
              ),
              Divider(),
              TabBar(
                labelColor: CustomTheme.of(context).accentColor,
                unselectedLabelColor:
                    CustomTheme.of(context).accentColor.withOpacity(0.3),
                tabs: <Widget>[
                  Tab(
                    text: "Детальніше",
                  ),
                  Tab(
                    text: "Коментарії",
                  )
                ],
              ),
              Expanded(
                  child: TabBarView(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ProblemDetailsContent(problem),
                ),
                CommentsMain(problem:problem),
              ])),
            ],
          )),
    );
  }
}
