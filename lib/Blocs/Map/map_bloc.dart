import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tllevo_driver/Blocs/Location/location_bloc.dart';
import 'package:tllevo_driver/Const/custom_image.dart';
import 'package:tllevo_driver/Models/route_destination.dart';
import 'package:tllevo_driver/Themes/tllevo_style.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<onMapInitializeEvent>(_onInitMap);
    on<onStartFollowingUserEvent>((event, emit) => emit(state.copyWith(isFollowUser: true)));
    on<onStopFollowingUserEvent>((event, emit) => emit(state.copyWith(isFollowUser: false)));
    on<UpdateUserPolylineEvent>( _onPolylineNewPoint );
    on<OnToggleUserRoute>((event, emit) => emit( state.copyWith( showMyRoute: !state.showMyRoute )) );
    
    on<DisplayPolylinesEvent>((event, emit) => emit( state.copyWith( polylines: event.polylines, markers: event.markers ) ));
 
    locationBloc.stream.listen((locationState) {
      
      if(!state.isFollowUser)return;
      if(locationState.lastKnowLocation == null) return;

      moveCamera(locationState.lastKnowLocation!);

    });

  }

void _onInitMap(onMapInitializeEvent event, Emitter<MapState> emit){
  _mapController = event.controller;
  _mapController!.setMapStyle(jsonEncode(TllevoStyle));
  emit(state.copyWith(isMapInitialized: true));
}

void _onPolylineNewPoint(UpdateUserPolylineEvent event, Emitter<MapState> emit) {

    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocations
    );

    final currentPolylines = Map<String, Polyline>.from( state.polylines );
    currentPolylines['myRoute'] = myRoute;

    emit( state.copyWith( polylines: currentPolylines ) );

  }


  Future drawRoutePolyline( RouteDestination destination ) async {

    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 5,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );

    final endMaker = await getAssetImageMarker('Assets/Images/finishPlace.png');
    final startMaker = await getAssetImageMarker('Assets/Images/startPlace.png');

    double kms = destination.distance / 1000;
    kms = (kms * 100).floorToDouble();
    kms /= 100;

    double tripDuration = (destination.duration / 60).floorToDouble(); 

    final startMarker = Marker(
      icon: startMaker,
      anchor: Offset(0.5, 0.6),
    markerId: const MarkerId('start'), 
    position: destination.points.first,
    infoWindow: InfoWindow(
      title: 'Inicio',
      snippet: 'Kms: $kms, duración: $tripDuration min'
    ));

    final endMarker = Marker(
    icon: endMaker,
    markerId: const MarkerId('end'), 
    position: destination.points.last,
    infoWindow: const InfoWindow(
      title: 'Fin',
      snippet: 'Punto final'
    ));


    final curretPolylines = Map<String, Polyline>.from( state.polylines );
    curretPolylines['route'] = myRoute;

    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

    add( DisplayPolylinesEvent( curretPolylines, currentMarkers ) );

    await Future.delayed(const Duration(milliseconds: 300));
    //_mapController?.showMarkerInfoWindow(const MarkerId('start'));

  }

  Future clearRoutes()async{
    final curretPolylines = Map<String, Polyline>.from( {} );
    final currentMarkers = Map<String, Marker>.from({});

    add( DisplayPolylinesEvent( curretPolylines, currentMarkers ) );
  }

void moveCamera(LatLng newLocation){
  final cameraUpdate = CameraUpdate.newLatLng(newLocation);
  _mapController?.animateCamera(cameraUpdate);
}

}
