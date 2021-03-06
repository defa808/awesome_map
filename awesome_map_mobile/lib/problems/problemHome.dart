import 'package:awesome_map_mobile/account/provder/accountProvider.dart';
import 'package:awesome_map_mobile/authorization/authorizationProvider.dart';
import 'package:awesome_map_mobile/base/filterContainer.dart';
import 'package:awesome_map_mobile/base/slidingUpPanelContainer.dart';
import 'package:awesome_map_mobile/base/title.dart';
import 'package:awesome_map_mobile/home/mapDetails.dart';
import 'package:awesome_map_mobile/home/mapListButton.dart';
import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:awesome_map_mobile/models/googleMap/markerType.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/problems/filter/problemFilter.dart';
import 'package:awesome_map_mobile/problems/problemDetailsContent.dart';
import 'package:awesome_map_mobile/problems/problemList.dart';
import 'package:awesome_map_mobile/problems/problemMap.dart';
import 'package:awesome_map_mobile/problems/providers/problemFilterModel.dart';
import 'package:awesome_map_mobile/problems/providers/problemMarkers.dart';
import 'package:awesome_map_mobile/services/problemService.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProblemHome extends StatefulWidget {
  ProblemHome({Key key}) : super(key: key);

  @override
  _ProblemHomeState createState() => _ProblemHomeState();
}

class _ProblemHomeState extends State<ProblemHome> {
  bool isShowList = false;
  @override
  void initState() {
    super.initState();
  }

  void showMap() {
    setState(() {
      isShowList = false;
    });
  }

  Widget mapListButton;
  MarkerId selectedItemLast;

  @override
  Widget build(BuildContext context) {
    // context.watch<ProblemMarkers>().getProblems();
    // Provider.of<GoogleMapModel>(context, listen: false).addListener(() {
    //   MarkerId selectedItem =
    //       Provider.of<GoogleMapModel>(context, listen: false).getSelectedItem();
    // });

    return Consumer<GoogleMapModel>(
      builder: (BuildContext context, GoogleMapModel model, Widget child) {
        MarkerId selectedItem = model.selectedMarker;

        if (selectedItemLast != selectedItem) isShowList = false;
        selectedItemLast = selectedItem;

        mapListButton = MapListButton(
          initialValue: isShowList ? 1 : 0,
          onListChange: () => setState(
            () {
              isShowList = true;
            },
          ),
          onMapChange: () => setState(() {
            isShowList = false;
          }),
        );

        return Stack(children: <Widget>[
          isShowList
              ? Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: mapListButton,
                    ),
                    Divider(),
                    Expanded(child: ProblemList()),
                  ],
                )
              : Stack(
                  children: <Widget>[
                    ProblemMap(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: mapListButton,
                    ),
                    if (model.selectedMarker != null)
                      Consumer<ProblemMarkers>(builder: (BuildContext context,
                          ProblemMarkers problemMarkers, Widget child) {
                        Problem problem = problemMarkers
                            .getProblemDetails(model.selectedMarker.value);

                        return problem != null
                            ? SlidingUpPanelContainer(
                                renderChild: (sc) => MapDetails(
                                      title: Header(
                                          text: problem?.title,
                                          tool: Consumer<AccountProvider>(
                                              builder: (BuildContext context,
                                                  AccountProvider value,
                                                  Widget child) {
                                            return value.roles.contains("Admin")
                                                ? PopupMenuButton<String>(
                                                    onSelected: (value) {
                                                      if (value ==
                                                          "changeStatus")
                                                        Navigator.pushNamed(
                                                            context,
                                                            '/changeProblemStatus',
                                                            arguments: problem);
                                                      if (value == "edit")
                                                        Navigator.pushNamed(
                                                            context,
                                                            '/editProblemDetail',
                                                            arguments: problem);
                                                    },
                                                    itemBuilder:
                                                        (BuildContext context) {
                                                      return [
                                                        PopupMenuItem<String>(
                                                            value: "edit",
                                                            child: Text(
                                                                "Редагувати"),
                                                            enabled: true),
                                                        PopupMenuItem<String>(
                                                            value:
                                                                "changeStatus",
                                                            child: Text(
                                                                "Змінити статус"),
                                                            enabled: true)
                                                      ];
                                                    },
                                                  )
                                                : Container();
                                          })),
                                      child: ProblemDetailsContent(problem),
                                      scrollController: sc,
                                    ),
                                isShow: model.selectedMarker != null)
                            : Container();
                      }),
                  ],
                ),
          FilterContainer(child: ProblemFilter())
        ]);
      },
    );
  }
}
