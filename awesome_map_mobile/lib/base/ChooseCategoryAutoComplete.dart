import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/services/problemService.dart';
import 'package:flutter/material.dart';

class ChooseCategoryAutoComplete extends StatefulWidget {
  const ChooseCategoryAutoComplete({
    Key key,
    this.getStore,
    this.selectedCategories,
    this.addCategory,
  }) : super(key: key);
  final List<Category> selectedCategories;
  final Future<List<Category>> Function() getStore;
  final void Function(Category) addCategory;

  @override
  _ChooseCategoryAutoCompleteState createState() =>
      _ChooseCategoryAutoCompleteState();
}

class _ChooseCategoryAutoCompleteState
    extends State<ChooseCategoryAutoComplete> {
  Future<List<Category>> storeInFuture;

  @override
  void initState() {
    super.initState();
    storeInFuture = executeStore();
  }

  Future<List<Category>> executeStore() async {
    return await widget.getStore();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
        future: storeInFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("Connection lost");
            case ConnectionState.active:
            case ConnectionState.waiting:
              return LinearProgressIndicator();
            case ConnectionState.done:
              return AutoCompleteTextField<Category>(
                clearOnSubmit: true,
                controller: TextEditingController(text: ""),
                decoration: InputDecoration(labelText: "Категорії"),
                suggestions: snapshot.data
                    .where((item) => widget.selectedCategories
                        .every((item2) => item2.id != item.id))
                    .toList(),
                itemBuilder: (BuildContext context, Category suggestion) =>
                    ListTile(
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
                itemSubmitted: (Category data) => widget.addCategory(data),
                key: null, //without key! it's important not rerendering
              );
            default:
              Text("done");
          }
        });
  }
}
