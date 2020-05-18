import 'package:awesome_map_mobile/models/googleMap/awesomeMarker.dart';
import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:awesome_map_mobile/models/googleMap/markerType.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/services/problemService.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProblemMarkers with ChangeNotifier {
  List<Problem> problems = new List<Problem>();
  GoogleMapModel googleMapModel;
  ProblemMarkers({this.googleMapModel});

  Future<List<Problem>> getProblems() async {
    problems = await ProblemService.getProblems();
    notifyListeners();
    return problems;
    // googleMapModel?.updateMarkers(createMarkers());
  }

  List<AwesomeMarker> createMarkers() {
    return problems.map<AwesomeMarker>((item) {
      return new AwesomeMarker(
          marker: new Marker(
            markerId: MarkerId(item.id),
            position: LatLng(item.latitude, item.longitude),
            infoWindow:
                InfoWindow(title: item.title),
          ),
          type: MarkerType.Problem);
    }).toList();
  }

  Problem getProblemDetails(String id) {
    return problems.where((element) => element.id == id)?.first;
  }

  void add(Problem problem) {
    problems.add(problem);
  }
}
