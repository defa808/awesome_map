import 'dart:io';

import 'package:awesome_map_mobile/base/chooseCategoryAutoComplete.dart';
import 'package:awesome_map_mobile/base/datepicker.dart';
import 'package:awesome_map_mobile/base/filePicker.dart';
import 'package:awesome_map_mobile/base/filter/categoryItem.dart';
import 'package:awesome_map_mobile/base/timePicker.dart';
import 'package:awesome_map_mobile/events/createEventItemContent.dart';
import 'package:awesome_map_mobile/events/providers/eventForm.dart';
import 'package:awesome_map_mobile/events/providers/eventMarkers.dart';
import 'package:awesome_map_mobile/models/base/category.dart';
import 'package:awesome_map_mobile/models/googleMap/awesomeMarker.dart';
import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:awesome_map_mobile/models/googleMap/markerType.dart';
import 'package:awesome_map_mobile/services/eventService.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
                color: CustomTheme.of(context).bottomAppBarColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              controller: scrollController,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 5),
                child: Consumer<EventForm>(builder: (context, model, _) {
                  return CreateEventItemContent(
                    first: model.first,
                    formKey: _formKey,
                    event: model.event,
                    addFile: model.addFile,
                    removeFile: model.removeFile,
                    files: model.files,
                    btnOk: FlatButton.icon(
                      textColor: Colors.blue,
                      icon: Icon(Icons.send, color: Colors.blue),
                      label: Text("Відправити"),
                      onPressed: () {
                        completeTicket();
                      },
                    ),
                    btnCancel: FlatButton.icon(
                      icon: Icon(Icons.clear),
                      label: Text("Скасувати"),
                      onPressed: () {
                        removeTicket();
                      },
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
