import 'package:awesome_map_mobile/base/categoryAutoComplete.dart';
import 'package:awesome_map_mobile/base/datepicker.dart';
import 'package:awesome_map_mobile/base/filter/categoryItem.dart';
import 'package:awesome_map_mobile/models/problem/problemStatus.dart';
import 'package:awesome_map_mobile/problems/providers/problemFilterModel.dart';
import 'package:awesome_map_mobile/problems/providers/problemTypes.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProblemFilter extends StatelessWidget {
  ProblemFilter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color mainColor = Colors.white; //Theme.of(context).secondaryHeaderColor;
    return Consumer<ProblemFilterModel>(
      builder: (BuildContext context, ProblemFilterModel model, Widget child) {
        return Container(
            color: CustomTheme.of(context).primaryColor,
            child: model.isShow
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 8.0),
                    child: ListView(shrinkWrap: true, children: <Widget>[
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
                                onChanged: (String value) {
                                  model.setTitle(value);
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: DatePicker(
                              labelText: "Дата створення",
                              initDate: model.createDate,
                              endDate: DateTime(2100),
                              onChange: (value) {
                                model.setStartDate(value);
                              },
                              firstDate: DateTime(2020),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 28,
                                ),
                                DropdownButton<ProblemStatus>(
                                    isExpanded: true,
                                    underline: Container(height:1.0,color:mainColor),
                                    iconEnabledColor: mainColor,
                                    selectedItemBuilder:
                                        (BuildContext context) {
                                      return ProblemStatus.values
                                          .map<Widget>((ProblemStatus item) {
                                        return Text(
                                          EnumToString.parseCamelCase(item),
                                        );
                                      }).toList();
                                    },
                                    hint: Text("Статус",
                                        style: TextStyle(color: mainColor)),
                                    style: TextStyle(color: mainColor),
                                    onChanged: (ProblemStatus newValue) {
                                      model.setStatus(newValue);
                                    },
                                    value: model.status >= 0
                                        ? ProblemStatus.values[model.status]
                                        : null,
                                    items: ProblemStatus.values
                                        .map((ProblemStatus classType) {
                                      return DropdownMenuItem<ProblemStatus>(
                                          value: classType,
                                          child: Text(
                                            EnumToString.parseCamelCase(
                                                classType),
                                            style:
                                                TextStyle(color: Colors.black),
                                          ));
                                    }).toList()),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(child: Consumer<ProblemTypes>(builder:
                              (BuildContext context, ProblemTypes store,
                                  Widget child) {
                            return CategoryAutoComplete(
                                model: model, store: store);
                          })),
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
                              child: CategoryItem(
                                label: Text(item.name),
                                icon: item.icon != null
                                    ? Icon(IconData(item.icon.iconCode,
                                        fontFamily: item.icon.fontFamily,
                                        fontPackage: item.icon.fontPackage))
                                    : null,
                                onDelete: () {
                                  model.removeCategory(item.id);
                                },
                              ),
                            )
                        ],
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: FlatButton(
                            child: Text("Cкинути",
                                style: TextStyle(color: mainColor)),
                            onPressed: model.reset,
                          ))
                    ]),
                  )
                : Container(
                    height: 0,
                  ));
      },
    );
  }
}
