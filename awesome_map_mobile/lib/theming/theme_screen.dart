import 'package:flutter/material.dart';

import 'custom_theme.dart';
import 'themes.dart';

class ThemeScreen extends StatefulWidget {
  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  void _changeTheme(BuildContext buildContext, MyThemeKeys key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Themes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  _changeTheme(context, MyThemeKeys.LIGHT);
                },
                child: Text("Light!"),
              ),
              RaisedButton(
                onPressed: () {
                  _changeTheme(context, MyThemeKeys.DARK);
                },
                child: Text("Dark!"),
              ),
              RaisedButton(
                onPressed: () {
                  _changeTheme(context, MyThemeKeys.DARKER);
                },
                child: Text("Darker!"),
              ),
              Divider(
                height: 100,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                color: Theme.of(context).primaryColor,
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
