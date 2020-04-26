import 'package:awesome_map_mobile/models/event/eventFilterModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventFilterButton extends StatelessWidget {
  const EventFilterButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EventFilterModel>(
      builder: (BuildContext context, EventFilterModel model, Widget child) {
        return Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Stack(
            children: <Widget>[
              IconButton(
                  iconSize: 30,
                  color: Colors.white,
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    Provider.of<EventFilterModel>(context).showOrHide();
                  }),
              if (model.filtersCount > 0)
                Positioned(
                  right: 0,
                  bottom: 13,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: new Text(
                      model.filtersCount.toString(),
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
