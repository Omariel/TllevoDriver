import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tllevo_driver/Api/api_home.dart';
import 'package:tllevo_driver/Api/api_login.dart';
import 'package:tllevo_driver/Blocs/Location/location_bloc.dart';
import 'package:tllevo_driver/Blocs/Map/map_bloc.dart';
import 'package:tllevo_driver/Const/const.dart';
import 'package:tllevo_driver/Pages/Cuenta/cuenta.dart';
import 'package:tllevo_driver/Views/map_view.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key, required this.timerOrders}) : super(key: key);
  Timer timerOrders;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;
  Timer? miTimer;
  String? tokenUser;
  Map myData = {};

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();
    //updateLocation();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    miTimer?.cancel();
    super.dispose();
  }

  void updateLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenUser = prefs.getString('tokenUser')!;
    miTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (tokenUser!.isNotEmpty) {
        Api().updateLocationDriver(
            locationBloc.state.lastKnowLocation!, tokenUser!);
      }
    });
  }

  void getMyData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenUser = prefs.getString('tokenUser')!;
    bool isAvailable = prefs.getBool('available') ?? true;
    // ignore: use_build_context_synchronously
    Api().myData(tokenUser!, context).then((value) {
      myData = value;
    }).then((value) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Cuenta(
                  tokenUser: tokenUser!,
                  data: myData,
                  miTimer: miTimer ??
                      Timer.periodic(const Duration(seconds: 5), (timer) {}),
                  miTimerOrder: widget.timerOrders,
                      available: isAvailable,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, locationState) {
        if (locationState.lastKnowLocation == null) {
          return const Center(
            child: Text('Espere, por favor...'),
          );
        }

        return BlocBuilder<MapBloc, MapState>(
          builder: (context, mapState) {
            Map<String, Polyline> polylines = Map.from(mapState.polylines);
            if (!mapState.showMyRoute) {
              polylines.removeWhere((key, value) => key == 'myRoute');
            }
            return SingleChildScrollView(
              child: Stack(
                children: [
                  MapView(
                    target: locationState.lastKnowLocation!,
                    polylines: polylines.values.toSet(),
                    marker: mapState.markers.values.toSet(),
                  ),
                  Positioned(
                    bottom: size.height * 0.2,
                    right: size.width * 0.07,
                    child: SizedBox(
                      height: 35,
                      width: 35,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            primary: Colors.white,
                            elevation: 3,
                          ),
                          onPressed: () {
                            final userLocation =
                                locationBloc.state.lastKnowLocation;
                            if (userLocation == null) {
                              Const().snackBarErrorSuccefull(
                                  context, 'No hay ubicación', Colors.red);
                              return;
                            }
                            mapBloc.moveCamera(userLocation);
                          },
                          child: const Icon(
                            Icons.my_location,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.07,
                    left: size.width * 0.07,
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            primary: Colors.black,
                            elevation: 3,
                          ),
                          onPressed: () {
                            getMyData();
                          },
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 30,
                          )),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
