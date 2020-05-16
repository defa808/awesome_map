import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:flutter/material.dart';

class ChooseCategoryAutoComplete extends StatelessWidget {
  const ChooseCategoryAutoComplete({
    Key key,
    this.store,
    this.selectedCategories,
    this.addCategory,
  }) : super(key: key);
  final List<Category> selectedCategories;
  final List<Category> store;
  final void Function(Category) addCategory;
  @override
  Widget build(BuildContext context) {
    return AutoCompleteTextField<Category>(
      decoration: InputDecoration(labelText: "Категорії"),
      suggestions: store
          .where((item) =>
              selectedCategories.every((item2) => item2.id != item.id))
          .toList(),
      itemBuilder: (BuildContext context, Category suggestion) => ListTile(
        leading: suggestion.icon != null
            ? Icon(IconData(suggestion.icon.iconCode,
                fontFamily: suggestion.icon.fontFamily,
                fontPackage: suggestion.icon.fontPackage))
            : null,
        title: Text(suggestion.name),
      ),
      itemSorter: (a, b) =>
          (a != null && b != null) ? a.name.compareTo(b.name) : true,
      itemFilter: (Category suggestion, String query) =>
          suggestion.name.toLowerCase().contains(query.toLowerCase()),
      itemSubmitted: (Category data) => addCategory(data),
      key: new GlobalKey<AutoCompleteTextFieldState<Category>>(),
    );
  }
}
