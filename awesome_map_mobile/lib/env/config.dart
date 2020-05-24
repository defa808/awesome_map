import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  final String apiUrl;
  final String clientId;
  AppConfig({this.apiUrl, this.clientId});

  static Future<AppConfig> forEnvironment() async {
    // set default to dev if nothing was passed
    String env = 'dev';

    // load the json file
    final contents = await rootBundle.loadString(
      'lib/env/dev.json',
    );

    // decode our json
    final json = jsonDecode(contents);

    // convert our JSON into an instance of our AppConfig class
    return AppConfig(apiUrl: json['apiUrl'], clientId: json['clientId']);
  }
}
