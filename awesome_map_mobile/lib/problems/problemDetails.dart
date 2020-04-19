import 'package:awesome_map_mobile/home/title.dart';
import 'package:awesome_map_mobile/problems/problemDetailContent.dart';
import 'package:flutter/material.dart';

class ProblemDetails extends StatefulWidget {
  ProblemDetails({Key key}) : super(key: key);

  @override
  _ProblemDetailsState createState() => _ProblemDetailsState();
}

class _ProblemDetailsState extends State<ProblemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Детальніше"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Row(
              //   children: <Widget>[
              //     Flexible(
              //       child: Text(
              //         "Розкидане сміття біля скверу",
              //         maxLines: 3,
              //         style: TextStyle(fontSize: 20),
              //       ),
              //     ),
              //   ],
              // ),
              Header(
                text: "Розкидане сміття біля скверу",
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              ProblemDetailContent(),
            ],
          ),
        ));
  }
}
