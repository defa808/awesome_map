import 'dart:convert';

import 'package:awesome_map_mobile/env/config.dart';
import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/models/user/userFull.dart';
import 'package:awesome_map_mobile/problems/providers/problemMarkers.dart';
import 'package:awesome_map_mobile/services/accountService.dart';
import 'package:awesome_map_mobile/services/authorizationService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AccountProvider extends ChangeNotifier {
  UserFull userInfo;
  GoogleSignInAccount googleAccount;

  updateUserInfo(UserFull userFull) {
    this.userInfo = userFull;
    notifyListeners();
  }

  updateGoogleAccount(GoogleSignInAccount googleSignInAccount) {
    this.googleAccount = googleSignInAccount;
    notifyListeners();
  }

  subsribeOnProblem(Problem problem) async {
    try {
      bool result =
          await GetIt.I.get<AccountService>().subscribeOnProblem(problem.id);
      if (result) {
        this.userInfo.observedProblems.add(problem);
        problem.subscribersCount += 1;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  unsubsribeOnProblem(Problem problem) async {
    try {
      bool result =
          await GetIt.I.get<AccountService>().unSubscribeOnProblem(problem.id);

      if (result) {
        this.userInfo.observedProblems.removeWhere((x) => x.id == problem.id);
        problem.subscribersCount -= 1;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

    subsribeOnEvent(Event event) async {
    try {
      bool result =
          await GetIt.I.get<AccountService>().subsribeOnEvent(event.id);
      if (result) {
        this.userInfo.observedEvents.add(event);
        event.subscribersCount += 1;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  unsubsribeOnEvent(Event event) async {
    try {
      bool result =
          await GetIt.I.get<AccountService>().unSubscribeOnEvent(event.id);

      if (result) {
        this.userInfo.observedEvents.removeWhere((x) => x.id == event.id);
        event.subscribersCount -= 1;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
