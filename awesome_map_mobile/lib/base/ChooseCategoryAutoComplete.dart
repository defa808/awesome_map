import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/services/problemService.dart';
import 'package:flutter/material.dart';

class ChooseCategoryAutoComplete extends StatefulWidget {
  const ChooseCategoryAutoComplete(
      {Key key,
      this.getStore,
      this.selectedCategories,
      this.addCategory,
      this.color = Colors.grey})
      : super(key: key);
  final List<Category> selectedCategories;
  final Future<List<Category>> Function() getStore;
  final void Function(Category) addCategory;
  final Color color;

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
              return LinearProgressIndicator(
                backgroundColor: widget.color ?? Colors.lightBlue,
              );
            case ConnectionState.done:
              {
                if (snapshot.hasError)
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Something go wrong",
                            style: TextStyle(color: Colors.red)),
                      ),
                      LinearProgressIndicator(
                        value: 100,
                      )
                    ],
                  );
                else
                  return AutoCompleteTextField<Category>(
                    clearOnSubmit: true,
                    style: TextStyle(color: widget.color ?? Colors.grey),
                    controller: TextEditingController(text: ""),
                    decoration: InputDecoration(
                        labelText: "Категорії",
                        fillColor: widget.color,
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: widget.color ?? Colors.grey)),
                        hintStyle: TextStyle(color: widget.color),
                        labelStyle: TextStyle(color: widget.color)),

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
                    itemSorter: (a, b) => (a != null && b != null)
                        ? a.name.compareTo(b.name)
                        : true,
                    itemFilter: (Category suggestion, String query) =>
                        query == null
                            ? true
                            : suggestion.name
                                .toLowerCase()
                                .contains(query.toLowerCase()),
                    itemSubmitted: (Category data) => widget.addCategory(data),
                    key: null, //without key! it's important not rerendering
                  );
                break;
              }
            default:
              Text("done");
          }
        });
  }
}
