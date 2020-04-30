import 'dart:io';
import 'package:awesome_map_mobile/models/googleMap/awesomeMarker.dart';
import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:awesome_map_mobile/models/googleMap/markerType.dart';
import 'package:awesome_map_mobile/models/problem/problemForm.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CreateProblemItem extends StatefulWidget {
  CreateProblemItem({Key key}) : super(key: key);

  @override
  _CreateProblemItemState createState() => _CreateProblemItemState();
}

class _CreateProblemItemState extends State<CreateProblemItem> {
  List<String> _typeProblems = [];
  final _formKey = GlobalKey<FormState>();
  ProblemForm _data = ProblemForm.empty();

  void completeTicket(context) async {
    Provider.of<GoogleMapModel>(context).removeLast();
    _formKey.currentState.save();
    Provider.of<ProblemForm>(context).save(_data);
    Provider.of<GoogleMapModel>(context).add(AwesomeMarker(
        marker: Marker(
            markerId: null,
            position: LatLng(_data.latitude, _data.longitude),
            infoWindow:
                InfoWindow(title: _data.title, snippet: _data.description)),
        type: MarkerType.Problem));
    Provider.of<ProblemForm>(context).clear();
  }

  void removeTicket() {
    Provider.of<GoogleMapModel>(context).removeLast();
    Provider.of<ProblemForm>(context).clear();
  }

  String _selectedTypeProblem;
  @override
  void initState() {
    super.initState();
    setState(() {
      _typeProblems = [
        "Довкілля",
        "Електоенергія",
        "Закон  і Порядок",
        "Здоров’я",
        "Каналізація",
        "Комунікація",
        "Надзвичайна Ситуація",
        "Сміття",
        "Інше"
      ];
    });
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
                child: Consumer<ProblemForm>(builder: (context, model, _) {
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
                                  initialValue: model.latitude.toString(),
                                  onSaved: (String value) {
                                    this._data.latitude = double.parse(value);
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
                                  initialValue: model.longitude.toString(),
                                  onSaved: (String value) {
                                    this._data.longitude = double.parse(value);
                                  }),
                            ),
                          ],
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Назва"),
                            onSaved: (String value) {
                              this._data.title = value;
                            }),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          hint: Text("Тип проблеми"),
                          items: _typeProblems.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          value: _selectedTypeProblem,
                          onSaved: (String value) {
                            this._data.typeProblemId = 0; //hard code
                          },
                          onChanged: (String value) {
                            setState(() {
                              _selectedTypeProblem = value;
                            });
                          },
                        ),
                        TextFormField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Опис"),
                            onSaved: (String value) {
                              this._data.description = value;
                            }),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "photo1",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "(85 Kb)",
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.cancel),
                              color: Color.fromRGBO(77, 77, 77, 0.8),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "photo2",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "(1 Mb)",
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.cancel),
                              color: Color.fromRGBO(77, 77, 77, 0.8),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        RaisedButton.icon(
                          textColor: Color.fromRGBO(77, 77, 77, 0.8),
                          label: Text("Додати зображення"),
                          icon: Icon(Icons.file_upload),
                          elevation: 0.0,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: () {},
                        ),
                        SizedBox(height: 10),
                        Divider(
                          height: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlatButton.icon(
                              textColor: Colors.blue,
                              icon: Icon(Icons.send, color: Colors.blue),
                              label: Text("Відправити"),
                              onPressed: () {
                                completeTicket(context);
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
