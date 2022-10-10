import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tllevo_driver/Blocs/Location/location_bloc.dart';
import 'package:tllevo_driver/Blocs/Map/map_bloc.dart';
import 'package:tllevo_driver/Blocs/Search/search_bloc.dart';
import 'package:tllevo_driver/Blocs/gps/gps_bloc.dart';
import 'package:tllevo_driver/Services/traffic_service.dart';
import 'package:tllevo_driver/splash.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => GpsBloc()),
    BlocProvider(create: (context) => LocationBloc()),
    BlocProvider(create: (context) => MapBloc(locationBloc:  BlocProvider.of<LocationBloc>(context))),
    BlocProvider(create: (context) => SearchBloc(trafficService: TrafficService()))

  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InitSplash(),
    );
  }
}
