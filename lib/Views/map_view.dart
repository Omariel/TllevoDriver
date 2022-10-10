import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tllevo_driver/Blocs/Map/map_bloc.dart';

class MapView extends StatelessWidget {
  MapView({Key? key, required this.target, required this.polylines, required this.marker}) : super(key: key);
  final LatLng target;
  final Set<Polyline> polylines;
  final Set<Marker> marker;

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final size = MediaQuery.of(context).size;
         final CameraPosition initialCameraPosition = CameraPosition(
      target: target,
      zoom: 15);
    return  SizedBox(
      height: size.height,
      width: size.width,
      child: Listener(
        onPointerMove:(event) =>
          mapBloc.add(onStopFollowingUserEvent()), 
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          markers: marker,
          polylines: polylines,
          onMapCreated: (controller) => mapBloc.add(onMapInitializeEvent(controller)) ,
          ),
      ));
      
  }
}