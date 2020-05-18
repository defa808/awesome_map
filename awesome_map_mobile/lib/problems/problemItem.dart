import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ProblemItem extends StatefulWidget {
  ProblemItem({Key key, @required this.problem}) : super(key: key);
  final Problem problem;
  @override
  _ProblemItemState createState() => _ProblemItemState();
}

class _ProblemItemState extends State<ProblemItem> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    String id = widget.problem.id;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            ListTileTheme(
              contentPadding: EdgeInsets.all(0),
              child: ExpansionTile(
                key: Key(id),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(widget.problem.title,
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
                      Text(widget.problem.subscribersCount.toString(), style: TextStyle(fontSize: 18)),
                      Text("Слідкують"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("25", style: TextStyle(fontSize: 18)),
                      Text("Коментарів"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("5", style: TextStyle(fontSize: 18)),
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
                       context.read<GoogleMapModel>().selectItem(MarkerId("marker_id_1"));
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
                          "12.10.19",
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          "12:10",
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
