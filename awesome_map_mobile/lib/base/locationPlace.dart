import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class LocationPlace extends StatefulWidget {
  const LocationPlace({Key key, this.latitude, this.longitude, this.color})
      : super(key: key);
  final double latitude;
  final double longitude;
  final MaterialColor color;

  @override
  _LocationPlaceState createState() => _LocationPlaceState();
}

class _LocationPlaceState extends State<LocationPlace> {
  Future<Placemark> futurePlaceMarker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePlaceMarker = executeGetAddress();
  }

  Future<Placemark> executeGetAddress() async {
    return context
      .read<GoogleMapModel>()
      .getAddressLocation(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Placemark>(
        future: futurePlaceMarker,
        builder: (BuildContext context, AsyncSnapshot<Placemark> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Flexible(
                  child: Wrap(
                    children: <Widget>[
                      Flexible(
                        child: Text(snapshot.data.thoroughfare,
                            style: TextStyle(color: widget.color)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(snapshot.data.subThoroughfare,
                            style: TextStyle(color: widget.color)),
                      ),
                    ],
                  ),
                );
              }
          }
        });
  }
}
