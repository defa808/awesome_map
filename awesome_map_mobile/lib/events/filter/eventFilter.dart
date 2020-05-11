import 'package:awesome_map_mobile/base/datepicker.dart';
import 'package:awesome_map_mobile/base/filter/filterItem.dart';
import 'package:awesome_map_mobile/events/providers/eventFilterModel.dart';
import 'package:awesome_map_mobile/models/base/categoryAutoComplete.dart';
import 'package:awesome_map_mobile/models/categories/eventTypes.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventFilter extends StatelessWidget {
  EventFilter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color mainColor = Colors.white; //Theme.of(context).secondaryHeaderColor;
    return Consumer<EventFilterModel>(
      builder: (BuildContext context, EventFilterModel model, Widget child) {
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
                        children: <Widget>[
                          Flexible(
                            child: DatePicker(
                              labelText: "Початкова дата",
                              initDate: model.startDate,
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
                                    labelText: "Місце"),
                                keyboardType: TextInputType.text,
                                initialValue: model.title,
                                style: TextStyle(color: mainColor),
                                onChanged: (String value) {
                                  model.setPlace(value);
                                }),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(child: Consumer<EventTypes>(builder:
                              (BuildContext context, EventTypes store,
                                  Widget child) {
                            return CategoryAutoComplete(
                                model: model, store: store);
                          }))
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
