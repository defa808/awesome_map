import 'package:awesome_map_mobile/models/googleMap/markerType.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AwesomeMarker{
  Marker marker;
  MarkerType type;
  AwesomeMarker({@required this.marker,@required  this.type});
}