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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Row(
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
                SizedBox(
                  height: 10,
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 8.0, bottom: 5.0),
                        child: Chip(
                          avatar: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.blue,
                            child: Icon(Icons.delete),
                          ),
                          label: Text("Сміття"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0, bottom: 5.0),
                        child: Chip(
                          avatar: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.blue,
                            child: Icon(Icons.security),
                          ),
                          label: Text("Охорона здоров'я"),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                    "Посилаючись на наведене вище опис проблеми, Швеція пропонує, щоб в разі (цього) контейнерів - цистерн і багатоелементних газових, призначених для перевезення небезпечних вантажів автомобільним та залізничним транспортом, дата наступної перевірки вказувалася на табличках, розташованих на обох бічних сторонах контейнерів."),
                ListTileTheme(
                  contentPadding: EdgeInsets.all(0),
                  child: ExpansionTile(
                    key: UniqueKey(),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            "Прикріплення",
                          ),
                        ),
                      ],
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Тут Мають бути файли"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text("Слідкують:", style: TextStyle(fontSize: 16)),
                    SizedBox(width: 10,),
                    Text("5"),
                    Icon(Icons.people_outline),
                    Expanded(child: Container(),),
                    RaisedButton(
                      child: Text("Слідкувати"),
                      onPressed: () {},
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Віджет коментарів")
              ],
            ),
          ),
        ));
  }
}
