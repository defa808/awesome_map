import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';

class ProblemItem extends StatefulWidget {
  int id;
  ProblemItem({Key key, this.id}) : super(key: key);
  @override
  _ProblemItemState createState() => _ProblemItemState();
}

class _ProblemItemState extends State<ProblemItem> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    int id = widget.id;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            ListTileTheme(
              contentPadding: EdgeInsets.all(0),
              child: ExpansionTile(
                key: Key(id.toString()),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        "Розкидане сміття біля скверу",
                        maxLines: 3,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                        "Посилаючись на наведене вище опис проблеми, Швеція пропонує, щоб в разі (цього) контейнерів - цистерн і багатоелементних газових, призначених для перевезення небезпечних вантажів автомобільним та залізничним транспортом, дата наступної перевірки вказувалася на табличках, розташованих на обох бічних сторонах контейнерів."),
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
                      Text("10", style: TextStyle(fontSize: 18)),
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
                  RaisedButton(
                    color: CustomTheme.of(context).buttonColor,
                    child: Text("Слідкувати"),
                    onPressed: () {},
                  ),
                  FlatButton(
                    color: CustomTheme.of(context).bottomAppBarColor,
                    child: Text("Детальніше"),
                    onPressed: () {
                      Navigator.pushNamed(context, '/problemDetail',
                          arguments: {'id': widget.id});
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
