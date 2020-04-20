import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:flutter/material.dart';

class ProblemFilterModel extends ChangeNotifier {

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String title = "";
  List<Category> selectedCategories = new List<Category>();
  bool isShow = false;
  void showOrHide() {
    isShow = !isShow;
    notifyListeners();
  }

  void setTitle(String value) {
    this.title = value;
    notifyListeners();
  }

  void setStartDate(DateTime date) {
    this.startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    this.endDate = date;
    notifyListeners();
  }

  void addCategory(Category value) {
    selectedCategories.add(value);
    notifyListeners();
  }

  removeCategory(String guid) {
    selectedCategories = selectedCategories.where((item) => item.guid != guid ).toList();
    notifyListeners();
  }
  
}