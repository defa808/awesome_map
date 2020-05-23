import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventMapDetails extends StatelessWidget {
  const EventMapDetails(this.event, {Key key}) : super(key: key);
  final Event event;
  String getLabel(int inValue, String mainLabel) {
    if (inValue % 10 == 1) return mainLabel + "у"; // годину || хвилину
    if ((21 < inValue % 10 && inValue % 10 <= 24)) return mainLabel + "и"; //години || хвилини
    return mainLabel;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, right: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.lightBlue,
                        ),
                        Flexible(
                          child: Text("Палац України",
                              style: TextStyle(color: Colors.lightBlue)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, right: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              DateFormat.yMEd()
                                  .format(event.startDate)
                                  .toString(),
                              style: TextStyle(color: Colors.lightBlue),
                            ),
                            SizedBox(height: 2),
                            Text(
                              DateFormat.Hms()
                                  .format(event.startDate)
                                  .toString(),
                              style: TextStyle(color: Colors.lightBlue),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, right: 8, bottom: 8),
                    child: Column(
                      children: <Widget>[
                        for (Category type in event.eventTypes)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              if (type.icon != null)
                                Icon(IconData(type.icon.iconCode,
                                    fontFamily: type.icon.fontFamily,
                                    fontPackage: type.icon.fontPackage)),
                              Flexible(
                                child: Text(type.name,
                                    style: TextStyle(color: Colors.lightBlue)),
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 8, bottom: 8),
                  child: Center(
                      child: Text(
                          "${event.duration.inHours} ${getLabel(event.duration.inHours, 'годин')} \n" + 
                          "${event.duration.inMinutes.remainder(60)} ${getLabel(event.duration.inMinutes.remainder(60), 'хвилин')}")),
                ),
              ),
            ],
          ),
        ),
        Wrap(
          children: <Widget>[Text(event.description)],
        ),
        Divider(height: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Учасників:", style: TextStyle(fontSize: 16)),
            SizedBox(
              width: 10,
            ),
            Text("5"),
            Icon(Icons.people_outline),
            Expanded(
              child: Container(),
            ),
            RaisedButton(
              color: CustomTheme.of(context).accentColor,
              textColor: CustomTheme.of(context).bottomAppBarColor,
              child: Text("Приєднатися"),
              onPressed: () {},
            ),
          ],
        )
        // Expanded(child: CommentsList()),
      ],
    ));
  }
}
