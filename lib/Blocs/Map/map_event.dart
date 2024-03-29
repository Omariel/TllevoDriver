part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class onMapInitializeEvent extends MapEvent {
  final GoogleMapController controller;

  onMapInitializeEvent(this.controller);
}


class onStopFollowingUserEvent extends MapEvent{}
class onStartFollowingUserEvent extends MapEvent{}

class UpdateUserPolylineEvent extends MapEvent {
  final List<LatLng> userLocations;
  const UpdateUserPolylineEvent(this.userLocations);
}

class OnToggleUserRoute extends MapEvent{}


class DisplayPolylinesEvent extends MapEvent {
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;
  const DisplayPolylinesEvent(this.polylines, this.markers);
}