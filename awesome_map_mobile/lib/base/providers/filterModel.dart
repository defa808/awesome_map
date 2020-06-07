import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:flutter/material.dart';

abstract class FilterModel extends ChangeNotifier {
  int filtersCount = 0;
  List<Category> selectedCategories = new List<Category>();
  bool isShow = false;
  void showOrHide() {
    isShow = !isShow;
    notifyListeners();
  }

  void addCategory(Category value) {
    selectedCategories.add(value);
    updateCounter();
    notifyListeners();
  }

  removeCategory(String guid) {
    selectedCategories =
        selectedCategories.where((item) => item.id != guid).toList();
    updateCounter();
    notifyListeners();
  }

  int checkChangedCounter();

  updateCounter() {
    filtersCount = 0;
    filtersCount = checkChangedCounter();
    filtersCount += this.selectedCategories.length;
    notifyListeners();
  }

  void resetAllFields();

  reset() {
    resetAllFields();
    selectedCategories = new List<Category>();
    updateCounter();
    notifyListeners();
  }
}
