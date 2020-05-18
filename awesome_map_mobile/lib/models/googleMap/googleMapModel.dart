import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'awesomeMarker.dart';
import 'markerType.dart';

class GoogleMapModel extends ChangeNotifier {
  GoogleMapController controller;
  LatLng centerKPI = LatLng(50.449601, 30.457368);
  CameraPosition currentCameraPosition;
  Map<MarkerId, AwesomeMarker> markers = <MarkerId, AwesomeMarker>{};
  int _markerIdCounter = 1;
  MarkerId selectedMarker;
  BitmapDescriptor customIcon;

  GoogleMapModel() {
    currentCameraPosition = new CameraPosition(target: centerKPI);
    // add(AwesomeMarker(
    //     marker: Marker(
    //       position: LatLng(50.449301, 30.459368),
    //       infoWindow:
    //           InfoWindow(title: 'Test Title', snippet: 'Sub Description'),
    //       markerId: null,
    //     ),
    //     type: MarkerType.Event));
    // add(
    //   AwesomeMarker(
    //       marker: Marker(
    //         position: LatLng(50.449891, 30.457668),
    //         infoWindow:
    //             InfoWindow(title: 'Test Title', snippet: 'Sub Description'),
    //         markerId: null,
    //       ),
    //       type: MarkerType.Problem),
    // );
  }

  void selectItem(MarkerId markerId) {
    onMarkerTapped(markerId);
  }

  MarkerId getSelectedItem() {
    return selectedMarker;
  }

  void add(AwesomeMarker data) {
    final MarkerId markerId = data.marker.markerId;
    final awesomeMarker = AwesomeMarker(
        marker: Marker(
          icon: getIconMarker(data.type),
          markerId: markerId,
          draggable: true,
          position: data.marker.position,
          infoWindow: data.marker.infoWindow,
          onTap: () {
            onMarkerTapped(markerId);
          },
          onDragEnd: (LatLng position) {
            _onMarkerDragEnd(markerId, position);
          },
        ),
        type: data.type);

    markers[markerId] = awesomeMarker;
    notifyListeners();
  }

  getIconMarker(MarkerType type) {
    return type == MarkerType.Problem
        ? BitmapDescriptor.defaultMarker
        : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan);
  }

  void onMarkerTapped(MarkerId markerId) {
    final Marker tappedMarker = markers[markerId].marker;
    if (tappedMarker != null) {
      if (markers.containsKey(selectedMarker)) {
        final Marker resetOld = markers[selectedMarker]
            .marker
            .copyWith(iconParam: getIconMarker(markers[selectedMarker].type));
        markers[selectedMarker].marker = resetOld;
      } 
      if(selectedMarker != markerId) {
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId].marker = newMarker;
      }else
        selectedMarker = null;


      notifyListeners();
    }
  }

  void _onMarkerDragEnd(MarkerId markerId, LatLng newPosition) async {
    final Marker tappedMarker = markers[markerId].marker;
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
    final MarkerId markerId = MarkerId("0");
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

  void updateMarkers(List<AwesomeMarker> createMarkers, {MarkerType markerType}) {
    if (markerType != null)
      markers.removeWhere((markerId, awesomeMarker) {
        return markerId != MarkerId("0") && awesomeMarker.type == markerType;
      });
    else
      markers.clear();

    createMarkers.forEach((item) {
      add(item);
    });
  }
}
