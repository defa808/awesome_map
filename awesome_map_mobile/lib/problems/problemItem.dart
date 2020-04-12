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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/problemDetail',
                      arguments: {'id': widget.id});
                },
                splashColor: colorScheme.onSurface.withOpacity(0.12),
                highlightColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
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
                )),
            ListTileTheme(
              contentPadding: EdgeInsets.all(0),
              child: ExpansionTile(
                key: Key(id.toString()),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Опис"),
                    Text(
                      "12.10.19 12:10",
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                        "Посилаючись на наведене вище опис проблеми, Швеція пропонує, щоб в разі контейнерів-цистерн і багатоелементних газових, призначених для перевезення небезпечних вантажів автомобільним та залізничним транспортом, дата наступної перевірки вказувалася на табличках, розташованих на обох бічних сторонах контейнерів."),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("25", style: TextStyle(fontSize: 18)),
                      Text("Слідкують"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("10", style: TextStyle(fontSize: 18)),
                      Text("Коментарів"),
                    ],
                  ),
                  RaisedButton(
                    color: Theme.of(context).buttonColor,
                    child: Text("Слідкувати"),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
