import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:flutter/material.dart';

class EventFilterModel extends ChangeNotifier {
  int filtersCount = 0;
  DateTime startDate;
  String place;
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

  void setPlace(String place) {
    this.place = place;
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
    if(this.place.isNotEmpty)  filtersCount++;
    filtersCount += this.selectedCategories.length;
  }

  void reset() {
    setTitle("");
    setStartDate(null);
    setPlace("");
    selectedCategories = new List<Category>();
    notifyListeners();
  }
}
