import 'package:awesome_map_mobile/base/chooseCategoryAutoComplete.dart';
import 'package:awesome_map_mobile/base/datepicker.dart';
import 'package:awesome_map_mobile/base/filter/categoryItem.dart';
import 'package:awesome_map_mobile/events/providers/eventFilterModel.dart';
import 'package:awesome_map_mobile/services/eventService.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
                              endDate: model.endDate ?? DateTime(2100),
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
                            child: DatePicker(
                              labelText: "Кінцева дата",
                              firstDate: model.startDate ?? DateTime(2020),
                              endDate: DateTime(2100),
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
                          Flexible(
                              child: ChooseCategoryAutoComplete(
                                  addCategory: model.addCategory,
                                  getStore: GetIt.I.get<EventService>().getCategories,
                                  selectedCategories: model.selectedCategories,
                                  color: Colors.white))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Wrap(
                              spacing: 0,
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                for (var item in model.selectedCategories)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: CategoryItem(
                                      label: Text(item.name),
                                      icon: item.icon != null
                                          ? Icon(IconData(item.icon.iconCode,
                                              fontFamily: item.icon.fontFamily,
                                              fontPackage:
                                                  item.icon.fontPackage))
                                          : null,
                                      onDelete: () {
                                        model.removeCategory(item.id);
                                      },
                                    ),
                                  )
                              ])
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
