import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:awesome_map_mobile/base/datepicker.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/problem/problemFilterModel.dart';
import 'package:awesome_map_mobile/problems/filter/filterItem.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProblemFilter extends StatelessWidget {
  ProblemFilter({Key key}) : super(key: key);
  final List<Category> categories = <Category>[
    Category(guid: "CVsdf", name: "Сміття", iconCode: Icons.delete.codePoint),
    Category(
        guid: "asdasd",
        name: "Охорона здоров'я",
        iconCode: Icons.security.codePoint)
  ];

  @override
  Widget build(BuildContext context) {
    Color mainColor = Colors.white; //Theme.of(context).secondaryHeaderColor;

    return Consumer<ProblemFilterModel>(
      builder: (BuildContext context, ProblemFilterModel model, Widget child) {
        return Container(
            color: CustomTheme.of(context).primaryColor,
            child: model.isShow
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(mainAxisSize: MainAxisSize.min, children: <
                        Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: TextFormField(
                                cursorColor: mainColor,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: mainColor)),
                                    hintStyle: TextStyle(color: mainColor),
                                    labelStyle: TextStyle(color: mainColor),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: mainColor)),
                                    labelText: "Назва"),
                                keyboardType: TextInputType.text,
                                initialValue: model.title,
                                style: TextStyle(color: mainColor),
                                onSaved: (String value) {
                                  model.setTitle(value);
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: DatePicker(
                              labelText: "Початкова дата",
                              initDate: model.startDate,
                              onChange: (value) {
                                model.setStartDate(value);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: DatePicker(
                              labelText: "Кінцева дата",
                              initDate: model.endDate,
                              onChange: (value) {
                                model.setEndDate(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                              child: AutoCompleteTextField<Category>(
                            style: TextStyle(color: mainColor),
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: mainColor),
                                labelStyle: TextStyle(color: mainColor),
                                suffixIcon: new Icon(
                                  Icons.search,
                                  color: mainColor,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: mainColor)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        color: mainColor)),
                                labelText: "Категорії"),
                            suggestions: categories
                                .where((item) => model.selectedCategories
                                    .every((item2) => item2.guid != item.guid))
                                .toList(),
                            itemBuilder:
                                (BuildContext context, Category suggestion) =>
                                    ListTile(
                              leading: Icon(IconData(suggestion.iconCode,
                                  fontFamily: 'MaterialIcons')),
                              title: Text(suggestion.name),
                            ),
                            itemSorter: (a, b) => a.name.compareTo(b.name),
                            itemFilter: (Category suggestion, String query) =>
                                suggestion.name
                                    .toLowerCase()
                                    .contains(query.toLowerCase()),
                            itemSubmitted: (Category data) =>
                                Provider.of<ProblemFilterModel>(context)
                                    .addCategory(data),
                            key: new GlobalKey<
                                AutoCompleteTextFieldState<Category>>(),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          for (var item in model.selectedCategories)
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: FilterItem(
                                label: Text(item.name),
                                icon: Icon(IconData(item.iconCode,
                                    fontFamily: 'MaterialIcons')),
                                onDelete: (){
                                    Provider.of<ProblemFilterModel>(context)
                                        .removeCategory(item.guid);
                                },
                              ),
                            )
                        ],
                      )
                    ]),
                  )
                : Container(
                    height: 0,
                  ));
      },
    );
  }
}
