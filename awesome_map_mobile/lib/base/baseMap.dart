import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:awesome_map_mobile/models/googleMap/markerType.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class BaseMap extends StatelessWidget {
  const BaseMap({Key key, this.filter}) : super(key: key);
  final MarkerType filter;
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
        markers: Set<Marker>.of(model.markers.values
            .where((x) => x.type == (filter ?? x.type))
            .map((x) => x.marker)),
        onMapCreated: (GoogleMapController controller) {
          context.read<GoogleMapModel>().setController(controller);
        },
      );
    });
  }
}
