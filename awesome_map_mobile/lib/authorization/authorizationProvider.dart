import 'dart:convert';

import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/main.dart';
import 'package:awesome_map_mobile/models/user/user.dart';
import 'package:awesome_map_mobile/services/authorizationService.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthorizationProvider extends ChangeNotifier {
  GoogleSignIn _googleSignIn;
  GoogleSignInAccount googleAccount;
  String email;
  String name;
  User userInfo;

  void googleInitAuth() async {
    AppConfig config = await AppConfig.forEnvironment();

    _googleSignIn = GoogleSignIn(
        scopes: <String>['email', 'profile', 'openid'],
        clientId: config.clientId);

    // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
    //   currentUser = account;
    //   notifyListeners();
    // });
  }

  Future<bool> handleSignIn({String email, String password}) async {
    try {
      if (email != null && password != null) {
        String token = await AuthorizationService.login(email, password);
        if (token == null) return false;
        var result = parseJwt(token);
        storage.write(key: "jwt", value: token);
        this.userInfo = await AuthorizationService.getInfo(email);
        return true;
      } else {
        googleAccount = await _googleSignIn.signIn();
        var identityHeader = (await googleAccount.authentication).accessToken;
        storage.write(key: "oauth", value: identityHeader);
        return googleAccount != null;
      }
    } catch (error) {
      print(error);
    }
    return false;
  }

  Future<void> handleSignOut() async {
    if (_googleSignIn != null) await _googleSignIn.disconnect();
    notifyListeners();
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
