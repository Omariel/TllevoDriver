import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:tllevo_driver/Models/model_places.dart';
import 'package:tllevo_driver/Models/route_destination.dart';
import 'package:tllevo_driver/Services/traffic_service.dart';


part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  
  TrafficService trafficService;

  SearchBloc({
    required this.trafficService
  }) : super(SearchState()) {
    on<onNewPlacesFoundEvent>((event, emit) => emit(state.copyWith(places: event.places)));
    on<SearchEvent>((event, emit) {

    });
  }


  Future<RouteDestination> getCoorsStartToEnd( LatLng start, LatLng end ) async {

    final trafficResponse = await trafficService.getCoorsStartToEnd(start, end);

    final geometry = trafficResponse.routes[0].geometry;
    final distance = trafficResponse.routes[0].distance;
    final duration = trafficResponse.routes[0].duration;

    // Decodificar
    final points = decodePolyline( geometry, accuracyExponent: 6 );

    final latLngList = points.map( ( coor ) => LatLng(coor[0].toDouble(), coor[1].toDouble()) ).toList();

    return RouteDestination(
      points: latLngList, 
      duration: duration, 
      distance: distance
    );

  }

  Future getPlacesByQuery(LatLng proximity, String query)async{

    final newPlaces = await trafficService.getResultsByQuery(proximity, query);

    add(onNewPlacesFoundEvent(newPlaces)); 

  }
}
