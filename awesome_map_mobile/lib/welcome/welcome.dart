import 'package:flutter/material.dart';
import 'dart:math' as math;

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "welcomeHeader",
      child: Container(
        padding: EdgeInsets.only(top: 80, left: 50, right: 50, bottom: 20),
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Awesome",
                      style: Theme.of(context).textTheme.headline.copyWith(
                          fontSize: 72.0,
                          color: Colors.white,
                          fontFamily: 'Adventure')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Transform.rotate(
                          angle: -30 * math.pi / 180,
                          child: Icon(
                            Icons.school,
                            color: Colors.white,
                            size: 110,
                          )),
                      Column(
                        children: <Widget>[
                          Text("Map",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(
                                      fontSize: 72.0,
                                      color: Colors.white,
                                      fontFamily: 'Adventure')),
                          Text("KPI",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(
                                      fontSize: 72.0,
                                      color: Colors.white,
                                      fontFamily: 'Adventure')),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Імпровізуй",
                          style: Theme.of(context).textTheme.body2.copyWith(
                              color: Colors.white,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Досліджуй",
                          style: Theme.of(context).textTheme.body2.copyWith(
                              color: Colors.white,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Вдосконалюй",
                          style: Theme.of(context).textTheme.body2.copyWith(
                              color: Colors.white,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                    ],
                  ),
                ]),
            Column(
              children: <Widget>[
                SizedBox(height: 10),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      side: BorderSide(color: Colors.white)),
                  minWidth: double.infinity,
                  height: 45,
                  color: Colors.white,
                  child: Text('Вхід'),
                  textColor: Colors.blue,
                  onPressed: () async {
                    final result =
                        await Navigator.pushNamed(context, '/signIn');
                  },
                ),
                SizedBox(height: 10),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      side: BorderSide(color: Colors.white)),
                  minWidth: double.infinity,
                  height: 45,
                  child: Text('Реєстрація'),
                  textColor: Colors.white,
                  onPressed: () async {
                    final result =
                        await Navigator.pushNamed(context, '/signUp');
                  },
                ),
                SizedBox(height: 10),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 40,
                  child: Text('Що я можу?'),
                  textColor: Colors.white,
                  onPressed: () async {
                    final result =
                        await Navigator.pushNamed(context, '/introduce');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
