import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MainMap extends StatefulWidget {
  MainMap({Key key}) : super(key: key) {}

  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  static LatLng centerKPI = LatLng(50.449601, 30.457368);
  GoogleMapController controller;
  CameraPosition currentCameraPosition = new CameraPosition(target: centerKPI);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  int _markerIdCounter = 1;
  bool isPrepareAdd = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _markerIdCounter = 1;
      isPrepareAdd = false;
      markers = <MarkerId, Marker>{};
    });
  }

  void _add() {
    isPrepareAdd = false;
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      draggable: true,
      position: this.currentCameraPosition.target,
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () {
        _onMarkerTapped(markerId);
      },
      onDragEnd: (LatLng position) {
        _onMarkerDragEnd(markerId, position);
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        if (markers.containsKey(selectedMarker)) {
          final Marker resetOld = markers[selectedMarker]
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[selectedMarker] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      });
    }
  }

  void _onMarkerDragEnd(MarkerId markerId, LatLng newPosition) async {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                actions: <Widget>[
                  FlatButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
                content: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 66),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Old position: ${tappedMarker.position}'),
                        Text('New position: $newPosition'),
                      ],
                    )));
          });
    }
  }

  void _currentLocation() async {
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
              backgroundColor: Colors.white,
              child: const Icon(Icons.my_location, color: Colors.blue),
              onPressed: _currentLocation),
          SizedBox(
            height: 15,
          ),
          isPrepareAdd
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FloatingActionButton(
                        child: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            isPrepareAdd = !isPrepareAdd;
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                        child: const Icon(Icons.done), onPressed: _add),
                  ],
                )
              : FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      isPrepareAdd = !isPrepareAdd;
                    });
                  }),
        ],
      ),
      body: Stack(children: <Widget>[
        GoogleMap(
          buildingsEnabled: true,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          initialCameraPosition: CameraPosition(
            target: centerKPI,
            zoom: 15.0,
          ),
          onCameraMove: (CameraPosition cameraPosition) {
            this.currentCameraPosition = cameraPosition;
          },
          markers: Set<Marker>.of(markers.values),
          onMapCreated: (GoogleMapController controller) {
            setState(() {
              this.controller = controller;
            });
          },
        ),
        if (isPrepareAdd == true)
          Center(
            child: Container(
              height: 90,
              width: 45,
              child: Align(
                  alignment: FractionalOffset.topCenter,
                  child: Icon(Icons.location_on, color: Colors.red, size: 45)),
            ),
          )
      ]),
    );
  }
}
