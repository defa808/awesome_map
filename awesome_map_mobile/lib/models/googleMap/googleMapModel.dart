import 'package:awesome_map_mobile/models/problem/problemForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapModel extends ChangeNotifier {
  GoogleMapController controller;
  LatLng centerKPI = LatLng(50.449601, 30.457368);
  CameraPosition currentCameraPosition;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  int _markerIdCounter = 1;
  MarkerId selectedMarker;

  GoogleMapModel() {
    currentCameraPosition = new CameraPosition(target: centerKPI);
    add(Marker(
      position: LatLng(50.449601, 30.457368),
      infoWindow: InfoWindow(title: 'Test Title', snippet: 'Sub Description'),
      markerId: null,
    ));
  }

  void selectItem(MarkerId markerId) {
    onMarkerTapped(markerId);
  }

  MarkerId getSelectedItem() {
    return selectedMarker;
  }

  void initMarker(List<Marker> markers) {
    for (var item in markers) {
      add(item);
    }
    notifyListeners();
  }

  void add(Marker data) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      draggable: true,
      position: data.position,
      infoWindow: data.infoWindow,
      onTap: () {
        onMarkerTapped(markerId);
      },
      onDragEnd: (LatLng position) {
        _onMarkerDragEnd(markerId, position);
      },
    );

    markers[markerId] = marker;
    notifyListeners();
  }

  void onMarkerTapped(MarkerId markerId) {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      if (markers.containsKey(selectedMarker)) {
        final Marker resetOld = markers[selectedMarker]
            .copyWith(iconParam: BitmapDescriptor.defaultMarker);
        markers[selectedMarker] = resetOld;
        selectedMarker = null;
      } else {
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      }

      notifyListeners();
    }
  }

  void _onMarkerDragEnd(MarkerId markerId, LatLng newPosition) async {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      // await showDialog<void>(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //           actions: <Widget>[
      //             FlatButton(
      //               child: const Text('OK'),
      //               onPressed: () => Navigator.of(context).pop(),
      //             )
      //           ],
      //           content: Padding(
      //               padding: const EdgeInsets.symmetric(vertical: 66),
      //               child: Column(
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: <Widget>[
      //                   Text('Old position: ${tappedMarker.position}'),
      //                   Text('New position: $newPosition'),
      //                 ],
      //               )));
      //     });
    }
  }

  GoogleMapController getController() {
    return this.controller;
  }

  void setController(GoogleMapController googleMapController) {
    this.controller = googleMapController;
    notifyListeners();
  }

  void removeLast() {
    final String markerIdVal = 'marker_id_' + (_markerIdCounter - 1).toString();
    final MarkerId markerId = MarkerId(markerIdVal);
    markers.remove(markerId);
    notifyListeners();
  }

  void setCurrentLocation() async {
    try {
      var location = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      this.controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              bearing: 0,
              target: LatLng(location.latitude, location.longitude),
              zoom: 17.0,
            ),
          ));
    } on Exception {}
  }

  LatLng getCurrentLatLon() {
    return currentCameraPosition.target;
  }
}
