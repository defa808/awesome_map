import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProblemItem extends StatefulWidget {
  ProblemItem({Key key, @required this.problem, this.beforeShowMap})
      : super(key: key);
  final Problem problem;
  final Function beforeShowMap;
  @override
  _ProblemItemState createState() => _ProblemItemState();
}

class _ProblemItemState extends State<ProblemItem> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            ListTileTheme(
              contentPadding: EdgeInsets.all(0),
              child: ExpansionTile(
                key: Key(widget.problem.id),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        widget.problem.title,
                        maxLines: 3,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(widget.problem.description),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.problem.subscribersCount.toString(),
                          style: TextStyle(fontSize: 18)),
                      Text("Слідкують"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.problem.commentsLength.toString(), style: TextStyle(fontSize: 18)),
                      Text("Коментарів"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.problem.files.length.toString(),
                          style: TextStyle(fontSize: 18)),
                      Text("Світлин"),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: CustomTheme.of(context).accentColor,
                      textColor: CustomTheme.of(context).bottomAppBarColor,
                      onPressed: () {
                       
                        context
                            .read<GoogleMapModel>()
                            .selectItem(MarkerId(widget.problem.id));
                             if (widget.beforeShowMap != null)
                          widget.beforeShowMap();
                      },
                      child: Text("На карті"),
                    ),
                  ),
                  FlatButton(
                    color: CustomTheme.of(context).bottomAppBarColor,
                    child: Text("Детальніше"),
                    onPressed: () {
                      Navigator.pushNamed(context, '/problemDetail',
                          arguments: widget.problem);
                    },
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          DateFormat.yMd()
                              .format(widget.problem.createDate)
                              .toString(),
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          DateFormat.Hm()
                              .format(widget.problem.createDate)
                              .toString(),
                          style: TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
