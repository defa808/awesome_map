import 'package:awesome_map_mobile/models/event/event.dart';
import 'package:awesome_map_mobile/models/googleMap/awesomeMarker.dart';
import 'package:awesome_map_mobile/models/googleMap/markerType.dart';
import 'package:awesome_map_mobile/services/eventService.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventMarkers with ChangeNotifier {
  List<Event> events = new List<Event>();

  Future<List<Event>> getEvents() async {
    events = await EventService.getEvents();
    return events;
  }

  List<AwesomeMarker> createMarkers() {
    return events.map<AwesomeMarker>((item) {
      return new AwesomeMarker(
          marker: new Marker(
            markerId: MarkerId(item.id),
            position: LatLng(item.latitude, item.longitude),
            infoWindow:
                InfoWindow(title: item.title),
          ),
          type: MarkerType.Event);
    }).toList();
  }

  Event getEventDetails(String id) {
    return events.where((element) => element.id == id)?.first;
  }

  void add(Event event) {
    events.add(event);
  }
}
