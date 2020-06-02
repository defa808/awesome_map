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
  List<String> roles;
  updateUserInfo(UserFull userFull) {
    this.userInfo = userFull;
    notifyListeners();
  }

  updateGoogleAccount(GoogleSignInAccount googleSignInAccount) {
    this.googleAccount = googleSignInAccount;
    notifyListeners();
  }

  subsribeOnProblem(Problem problem) async {
    this.userInfo.observedProblemIds.add(problem.id);
    problem.subscribersCount += 1;
    notifyListeners();

    try {
      bool result =
          await GetIt.I.get<AccountService>().subscribeOnProblem(problem.id);
      if (result == false) {
        this.userInfo.observedProblemIds.remove(problem.id);
        problem.subscribersCount -= 1;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      this.userInfo.observedProblemIds.remove(problem.id);
      problem.subscribersCount -= 1;
      notifyListeners();
    }
  }

  unsubsribeOnProblem(Problem problem) async {
    try {
      bool result =
          await GetIt.I.get<AccountService>().unSubscribeOnProblem(problem.id);

      if (result) {
        this.userInfo.observedProblemIds.removeWhere((x) => x == problem.id);
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
        this.userInfo.observedEventIds.add(event.id);
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
        this.userInfo.observedEventIds.removeWhere((x) => x == event.id);
        event.subscribersCount -= 1;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void setRoles(List<String> roles) {
    this.roles = roles;
    this.notifyListeners();
  }

  addProblem(String problemId) {
    this.userInfo.myProblemIds.add(problemId);
    this.userInfo.observedProblemIds.add(problemId);
    notifyListeners();
  }

  addEvent(String eventId) {
    this.userInfo.myEventIds.add(eventId);
    this.userInfo.observedEventIds.add(eventId);
    notifyListeners();
  }
}
