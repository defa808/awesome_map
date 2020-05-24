import 'package:awesome_map_mobile/env/config.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthorizationProvider extends ChangeNotifier {
  GoogleSignIn _googleSignIn;

  GoogleSignInAccount currentUser;

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

  Future<bool> handleSignIn() async {
    try {
      currentUser = await _googleSignIn.signIn();
      return currentUser != null;
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleSignOut() async {
    await _googleSignIn.disconnect();
    notifyListeners();
  }
}
