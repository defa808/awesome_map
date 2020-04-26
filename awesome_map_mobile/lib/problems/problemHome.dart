import 'package:awesome_map_mobile/base/filterContainer.dart';
import 'package:awesome_map_mobile/home/mapDetails.dart';
import 'package:awesome_map_mobile/home/mapListButton.dart';
import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:awesome_map_mobile/problems/filter/problemFilter.dart';
import 'package:awesome_map_mobile/problems/problemDetailsContent.dart';
import 'package:awesome_map_mobile/problems/problemList.dart';
import 'package:awesome_map_mobile/problems/problemMap.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

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
                    if (selectedItemLast != null)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: MapDetails(child: ProblemDetailsContent()),
                      )
                  ],
                ),
          FilterContainer(child: ProblemFilter())
        ]);
      },
    );
  }
}
