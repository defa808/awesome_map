import 'package:flutter/material.dart';

class SettingsHome extends StatelessWidget {
  const SettingsHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Налаштування'),
          centerTitle: true,
        ),
        body: Material(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: Text("Мова", style: TextStyle(fontSize: 16)),
                  ),
                  Flexible(
                    child: DropdownButton<String>(
                      value: "Українська",
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (String newValue) {},
                      items: <String>['Українська']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              )
              
            ],
          ),
        ));
  }
}
