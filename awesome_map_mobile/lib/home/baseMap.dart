import 'package:awesome_map_mobile/models/googleMapModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class BaseMap extends StatelessWidget {
  const BaseMap({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GoogleMapModel>(builder: (context, model, _) {
      return GoogleMap(
    buildingsEnabled: true,
    mapToolbarEnabled: false,
    myLocationEnabled: true,
    myLocationButtonEnabled: false,
    initialCameraPosition: CameraPosition(
      target: model.centerKPI,
      zoom: 15.0,
    ),
    onCameraMove: (CameraPosition cameraPosition) {
      model.currentCameraPosition = cameraPosition;
    },
    markers: Set<Marker>.of(model.markers.values),
    onMapCreated: (GoogleMapController controller) {
      Provider.of<GoogleMapModel>(context).setController(controller);
    },
      );
    });
  }
}
