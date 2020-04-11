import 'package:flutter/material.dart';

class AppConfig extends ChangeNotifier {
  // AppConfig(this._appConfigData);
  // AppConfigData _appConfigData;
  // AppConfigData get appConfigData => _appConfigData;
  // set appConfigData(AppConfigData appConfigData){
  //   _appConfigData = appConfigData;
  //   notifyListeners();
  // }

  Widget title;
  List<Widget> actions = new List<Widget>();
  Widget floatingButton;

  void setSettings(
      {Widget title, List<Widget> actions, Widget floatingButton}) {
    this.title = title ?? this.title;
    this.actions = actions ?? this.actions;
    this.floatingButton = floatingButton ?? this.floatingButton;
    this.notifyListeners();
  }
}
