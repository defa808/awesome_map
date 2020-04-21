import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:flutter/material.dart';

class ProblemFilterModel extends ChangeNotifier {
  int filtersCount = 0;
  DateTime startDate;
  DateTime endDate;
  String title = "";
  List<Category> selectedCategories = new List<Category>();
  bool isShow = false;
  void showOrHide() {
    isShow = !isShow;
    notifyListeners();
  }

  void setTitle(String value) {
    this.title = value;
    updateCounter();
    notifyListeners();
  }

  void setStartDate(DateTime date) {
    this.startDate = date;
    updateCounter();
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    this.endDate = date;
    updateCounter();

    notifyListeners();
  }

  void addCategory(Category value) {
    selectedCategories.add(value);
    updateCounter();
    notifyListeners();
  }

  removeCategory(String guid) {
    selectedCategories =
        selectedCategories.where((item) => item.guid != guid).toList();
    updateCounter();
    notifyListeners();
  }

  updateCounter() {
    filtersCount = 0;
    if (this.title.isNotEmpty) filtersCount++;
    if(this.startDate != null)  filtersCount++;
    if(this.endDate != null)  filtersCount++;
    filtersCount += this.selectedCategories.length;
  }

  void reset() {
    setTitle("");
    setStartDate(null);
    setEndDate(null);
    selectedCategories = new List<Category>();
    notifyListeners();
  }
}
