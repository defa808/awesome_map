import 'package:awesome_map_mobile/models/googleMap/awesomeMarker.dart';
import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:awesome_map_mobile/models/googleMap/markerType.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/problems/providers/problemFilterModel.dart';
import 'package:awesome_map_mobile/services/problemService.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProblemMarkers with ChangeNotifier {
  List<Problem> problems = new List<Problem>();
  List<Problem> filteredProblems = new List<Problem>();
  ProblemMarkers();
  ProblemFilterModel filter;
  Future<List<Problem>> getProblems() async {
    problems = await ProblemService.getProblems();
    filteredProblems = problems;
    if (filter != null) updateProblems(filter);

    notifyListeners();

    return filteredProblems;
    // googleMapModel?.updateMarkers(createMarkers());
  }

  List<AwesomeMarker> createMarkers() {
    return filteredProblems.map<AwesomeMarker>((item) {
      return new AwesomeMarker(
          marker: new Marker(
            markerId: MarkerId(item.id),
            position: LatLng(item.latitude, item.longitude),
            infoWindow: InfoWindow(title: item.title),
          ),
          type: MarkerType.Problem);
    }).toList();
  }

  Problem getProblemDetails(String id) {
    List<Problem> selectedEntities =
        problems.where((element) => element.id == id).toList();
    if (selectedEntities.length == 0) return null;
    return selectedEntities.first;
  }

  void add(Problem problem) {
    problems.add(problem);
  }

  void updateFilter(ProblemFilterModel filterProvider) {
    filter = filterProvider;
    updateProblems(filter);
    notifyListeners();
  }

  void updateProblems(ProblemFilterModel filter) {
    filteredProblems = problems
        .where((element) =>
            (filter.title != null
                ? element.title.contains(filter.title)
                : true) &&
            (filter.status >= 0 ? element.status == filter.status : true) &&
            (filter.createDate != null
                ? element.createDate == filter.createDate
                : true) &&
            (filter.selectedCategories.length > 0
                ? filter.selectedCategories.every(
                    (type) => element.problemTypes.any((x) => x.id == type.id))
                : true))
        .toList();
  }
}
