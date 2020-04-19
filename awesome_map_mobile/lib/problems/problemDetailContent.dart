import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';

class ProblemDetailContent extends StatelessWidget {
  const ProblemDetailContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8.0, bottom: 5.0),
                child: Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    foregroundColor:
                        CustomTheme.of(context).chipTheme.labelStyle.color,
                    child: Icon(Icons.delete),
                  ),
                  label: Text("Сміття"),
                  backgroundColor:
                      CustomTheme.of(context).chipTheme.backgroundColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0, bottom: 5.0),
                child: Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    foregroundColor:
                        CustomTheme.of(context).chipTheme.labelStyle.color,
                    child: Icon(Icons.security),
                  ),
                  label: Text("Охорона здоров'я"),
                ),
              ),
            ],
          ),
          Text(
              "Посилаючись на наведене вище опис проблеми, Швеція пропонує, щоб в разі (цього) контейнерів - цистерн і багатоелементних газових, призначених для перевезення небезпечних вантажів автомобільним та залізничним транспортом, дата наступної перевірки вказувалася на табличках, розташованих на обох бічних сторонах контейнерів."),
          SizedBox(
            height: 10,
          ),
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
              SizedBox(
                width: 10,
              ),
              Text("5"),
              Icon(Icons.people_outline),
              Expanded(
                child: Container(),
              ),
              RaisedButton(
                child: Text("Слідкувати"),
                onPressed: () {},
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "Активність",
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Створено:"),
              Text(
                "12.10.19 12:10",
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Відредаговано:"),
              Text(
                "13.10.19 10:00",
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          Text("Віджет коментарів")
        ],
      ),
    );
  }
}
