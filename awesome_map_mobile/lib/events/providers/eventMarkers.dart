import 'package:awesome_map_mobile/events/providers/eventFilterModel.dart';
import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:awesome_map_mobile/models/googleMap/awesomeMarker.dart';
import 'package:awesome_map_mobile/models/googleMap/markerType.dart';
import 'package:awesome_map_mobile/services/eventService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventMarkers with ChangeNotifier {
  List<Event> events = new List<Event>();
  List<Event> filteredEvents = new List<Event>();

  EventFilterModel filter;

  Future<List<Event>> getEvents() async {
    events = await GetIt.I.get<EventService>().getEvents();
    filteredEvents = events;
    if (filter != null) updateProblems(filter);

    return filteredEvents;
  }

  List<AwesomeMarker> createMarkers() {
    return filteredEvents.map<AwesomeMarker>((item) {
      return new AwesomeMarker(
          marker: new Marker(
            markerId: MarkerId(item.id),
            position: LatLng(item.latitude, item.longitude),
            infoWindow: InfoWindow(title: item.title),
          ),
          type: MarkerType.Event);
    }).toList();
  }

  Event getEventDetails(String id) {
    List<Event> selectedEvents =
        events.where((element) => element.id == id).toList();
    if (selectedEvents.length == 0) return null;
    return selectedEvents.first;
  }

  void add(Event event) {
    events.add(event);
  }

  void updateFilter(EventFilterModel filterProvider) {
    filter = filterProvider;
    updateProblems(filter);
    notifyListeners();
  }

  void updateProblems(EventFilterModel filter) {
    filteredEvents = events
        .where((element) =>
            (filter.title != null
                ? element.title.contains(filter.title)
                : true) &&
            (filter.startDate != null
                ? filter.startDate.isBefore(element.startDate)
                : true) &&
            (filter.endDate != null
                ? filter.endDate
                    .isAfter(element.startDate.add(element.duration))
                : true) &&
            (filter.selectedCategories.length > 0
                ? filter.selectedCategories.every(
                    (type) => element.eventTypes.any((x) => x.id == type.id))
                : true))
        .toList();
  }
}
