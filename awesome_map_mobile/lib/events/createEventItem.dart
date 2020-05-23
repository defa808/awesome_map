import 'dart:io';

import 'package:awesome_map_mobile/base/chooseCategoryAutoComplete.dart';
import 'package:awesome_map_mobile/base/filePicker.dart';
import 'package:awesome_map_mobile/base/filter/categoryItem.dart';
import 'package:awesome_map_mobile/events/providers/eventForm.dart';
import 'package:awesome_map_mobile/events/providers/eventMarkers.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/googleMap/awesomeMarker.dart';
import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:awesome_map_mobile/models/googleMap/markerType.dart';
import 'package:awesome_map_mobile/services/eventService.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CreateEventItem extends StatefulWidget {
  CreateEventItem({Key key}) : super(key: key);

  @override
  _CreateEventItemState createState() => _CreateEventItemState();
}

class _CreateEventItemState extends State<CreateEventItem> {
  List<String> _typeEvents = [];
  final _formKey = GlobalKey<FormState>();

  void completeTicket() async {
    try {
      context.read<GoogleMapModel>().removeLast();
      _formKey.currentState.save();
      EventForm provider = context.read<EventForm>();
      if (await provider.save()) {
        context.read<GoogleMapModel>().add(AwesomeMarker(
            marker: Marker(
                markerId: MarkerId(provider.event.id),
                position:
                    LatLng(provider.event.latitude, provider.event.longitude),
                infoWindow: InfoWindow(title: provider.event.title)),
            type: MarkerType.Event));
        context.read<EventMarkers>().add(provider.event);
        provider.clear();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void removeTicket() {
    context.read<GoogleMapModel>().removeLast();
    context.read<EventForm>().clear();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, //important part
      child: DraggableScrollableSheet(
        minChildSize: 0.4,
        maxChildSize: 0.85,
        initialChildSize: 0.5,
        expand: true,
        builder: (context, scrollController) {
          return Container(
            padding: EdgeInsets.only(top: 25),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[400], spreadRadius: 1, blurRadius: 7)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              controller: scrollController,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 5),
                child: Consumer<EventForm>(builder: (context, model, _) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Center(
                          child: Container(
                              height: 5,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(18))),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: "Широта",
                                      hintText: "Широта"),
                                  keyboardType: TextInputType.number,
                                  initialValue: model.event.latitude.toString(),
                                  onSaved: (String value) {
                                    model.event.latitude = double.parse(value);
                                  }),
                            ),
                            SizedBox(width: 50),
                            Flexible(
                              child: TextFormField(
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: "Довгота",
                                      hintText: "Довгота"),
                                  keyboardType: TextInputType.number,
                                  initialValue:
                                      model.event.longitude.toString(),
                                  onSaved: (String value) {
                                    model.event.longitude = double.parse(value);
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Wrap(
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.start,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: <Widget>[
                              for (Category item in model.event.eventTypes)
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
                                      }),
                                )
                            ]),
                        ChooseCategoryAutoComplete(
                            getStore: EventService.getCategories,
                            selectedCategories: model.event.eventTypes,
                            addCategory: model.addCategory),
                        SizedBox(height: 10),
                        TextFormField(
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Назва"),
                            onSaved: (String value) {
                              model.event.title = value;
                            }),
                        SizedBox(height: 10),
                        TextFormField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Опис"),
                            onSaved: (String value) {
                              model.event.description = value;
                            }),
                        SizedBox(height: 10),
                        FilePicker(),
                        SizedBox(height: 10),
                        Divider(height: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlatButton.icon(
                              textColor: Colors.blue,
                              icon: Icon(Icons.send, color: Colors.blue),
                              label: Text("Відправити"),
                              onPressed: () {
                                completeTicket();
                              },
                            ),
                            FlatButton.icon(
                              icon: Icon(Icons.clear),
                              label: Text("Скасувати"),
                              onPressed: () {
                                removeTicket();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
