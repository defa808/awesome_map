import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/base/filterModel.dart';
import 'package:awesome_map_mobile/models/categories/categories.dart';
import 'package:flutter/material.dart';

class CategoryAutoComplete extends StatelessWidget {
  const CategoryAutoComplete(
      {Key key, @required this.model, @required this.store})
      : super(key: key);
  final Color mainColor =
      Colors.white; //Theme.of(context).secondaryHeaderColor;
  final FilterModel model;
  final Categories store;
  @override
  Widget build(BuildContext context) {
    store.tryLoad();
    return AutoCompleteTextField<Category>(
      style: TextStyle(color: mainColor),
      decoration: InputDecoration(
          hintStyle: TextStyle(color: mainColor),
          labelStyle: TextStyle(color: mainColor),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
          enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(style: BorderStyle.solid, color: mainColor)),
          labelText: "Категорії"),
      suggestions: store.categories
          .where((item) =>
              model.selectedCategories.every((item2) => item2.id != item.id))
          .toList(),
      itemBuilder: (BuildContext context, Category suggestion) => ListTile(
        leading: suggestion.icon != null
            ? Icon(IconData(suggestion.icon.iconCode,
                fontFamily: suggestion.icon.fontFamily,
                fontPackage: suggestion.icon.fontPackage))
            : null,
        title: Text(suggestion.name),
      ),
      itemSorter: (a, b) => a.name.compareTo(b.name),
      itemFilter: (Category suggestion, String query) =>
          suggestion.name.toLowerCase().contains(query.toLowerCase()),
      itemSubmitted: (Category data) => model.addCategory(data),
      key: new GlobalKey<AutoCompleteTextFieldState<Category>>(),
    );
  }
}
