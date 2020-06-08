import 'package:awesome_map_mobile/models/googleMap/awesomeMarker.dart';
import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:awesome_map_mobile/models/googleMap/markerType.dart';
import 'package:awesome_map_mobile/problems/createProblemItemContent.dart';
import 'package:awesome_map_mobile/problems/providers/problemForm.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'providers/problemMarkers.dart';

class CreateProblemItem extends StatefulWidget {
  CreateProblemItem({Key key}) : super(key: key);
  @override
  _CreateProblemItemState createState() => _CreateProblemItemState();
}

class _CreateProblemItemState extends State<CreateProblemItem> {
  final _formKey = GlobalKey<FormState>();

  void completeTicket() async {
    _formKey.currentState.save();
    ProblemForm provider = context.read<ProblemForm>();
    if (await provider.save()) {
      context.read<GoogleMapModel>().removeLast();
      context.read<GoogleMapModel>().add(AwesomeMarker(
          marker: Marker(
              markerId: MarkerId(provider.problem.id),
              position:
                  LatLng(provider.problem.latitude, provider.problem.longitude),
              infoWindow: InfoWindow(title: provider.problem.title)),
          type: MarkerType.Problem));
      context.read<ProblemMarkers>().add(provider.problem);
      provider.clear();
    }
  }

  void removeTicket() {
    context.read<GoogleMapModel>().removeLast();
    context.read<ProblemForm>().clear();
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
                            color: Colors.grey[400],
                            spreadRadius: 1,
                            blurRadius: 7)
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
                        child:
                            Consumer<ProblemForm>(builder: (context, model, _) {
                          return CreateProblemItemContent(
                            first: model.first,
                            formKey: _formKey,
                            problem: model.problem,
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
                      )));
            }));
  }
}
