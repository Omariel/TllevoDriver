import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tllevo_driver/Api/api_home.dart';
import 'package:tllevo_driver/Api/api_login.dart';
import 'package:tllevo_driver/Blocs/Location/location_bloc.dart';
import 'package:tllevo_driver/Blocs/Map/map_bloc.dart';
import 'package:tllevo_driver/Blocs/Search/search_bloc.dart';
import 'package:tllevo_driver/Blocs/gps/gps_bloc.dart';
import 'package:tllevo_driver/Models/search_result.dart';
import 'package:tllevo_driver/Pages/Cuenta/cuenta.dart';
import 'package:tllevo_driver/Pages/Home/selected_viaje.dart';
import 'package:tllevo_driver/Pages/Home/solicitudes.dart';
import 'package:tllevo_driver/Pages/map_screen.dart';
import 'package:tllevo_driver/Widget/button.dart';
import 'package:tllevo_driver/Widget/column_builder.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  Home({Key? key, required this.show}) : super(key: key);
  bool show;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isDragabble = false;
  Map myData = {};
  List myOrders = [];
  List orderSelected = [];
  Timer? miTimer;
  late String tokenUser;

  @override
  void initState() {
    orderActive();
    super.initState();
  }

  void orderActive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenUser = prefs.getString('tokenUser')!;
    ApiHome().availableState(tokenUser, context).then((value) {
      value ? prefs.setBool('available', true) : null;
    });
    ApiHome().orderActive(tokenUser, context).then((value) {
      List data = value;
      value.isNotEmpty
          ? setState(() {
              Api().myData(tokenUser, context).then((value) {
                myData = value;
                String info = data[0]['created_at'];
                String fecha = '';
                String hora = '';
                var sep = info.split('T');
                var sep2 = sep[1].split('.');
                fecha = sep[0];
                hora = sep2[0];
                orderSelected = [
                  fecha,
                  hora,
                  data[0]['user_address_from']['address'],
                  data[0]['user_address_from']['address_no'],
                  data[0]['user_address']['address'],
                  data[0]['user_address']['address_no'],
                  data[0]['cost_delivery'],
                  data[0]['state']['value'],
                  data[0]['id'],
                  LatLng(double.parse(data[0]['user_address_from']['latitude']),
                      double.parse(data[0]['user_address_from']['longitude'])),
                  LatLng(double.parse(data[0]['user_address']['latitude']),
                      double.parse(data[0]['user_address']['longitude'])),
                  data[0]['user']['name'],
                  data[0]['user']['email']
                ];
                setState(() {
                  isDragabble = true;
                });
              });
            })
          : ordersPendient();
    });
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenUser = prefs.getString('tokenUser')!;
    // ignore: use_build_context_synchronously
    Api().myData(tokenUser, context).then((value) {
      myData = value;
      setState(() {
        isDragabble = true;
      });
    });
  }

  void ordersPendient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenUser = prefs.getString('tokenUser')!;
    miTimer = Timer.periodic(const Duration(seconds: 20), (timer) {
      if (tokenUser.isNotEmpty) {
        ApiHome().orderPendient(tokenUser, context).then((value) => setState(
              () {
                myOrders = value;
              },
            ));
        print(myOrders[0]['user_address']);
      }
    });
  }

  void buscandoPersona(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenUser = prefs.getString('tokenUser')!;
    // ignore: use_build_context_synchronously
    ApiHome().buscandoPersona(tokenUser, id, context);
  }

  @override
  void dispose() {
    miTimer?.cancel();
    super.dispose();
  }

  void onSearchPersona(
    BuildContext context,
    LatLng start,
  ) async {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    // if (result.manual == true) {
    //   //searchBloc.add( OnActivateManualMarkerEvent() );
    //   return;
    // }

    if (start != null) {
      //final destination = await searchBloc.getCoorsStartToEnd(start, end);
      final destination = await searchBloc.getCoorsStartToEnd(
          locationBloc.state.lastKnowLocation!, start);
      await mapBloc.drawRoutePolyline(destination);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            return state.isAllGrantes
                ? Stack(
                    children: [
                      MapScreen(timerOrders: miTimer ?? Timer.periodic(const Duration(seconds: 20), (timer) {}),),
                      isDragabble
                          ? DraggableBottomSheet(
                              hisName: orderSelected[11],
                              hisEmail: orderSelected[12],
                              start: orderSelected[9],
                              end: orderSelected[10],
                              tokenUser: tokenUser,
                              id: orderSelected[8],
                              myEmail: myData['email'],
                              status: orderSelected[7],
                              date: orderSelected[0],
                              time: orderSelected[1],
                              dist: '5km',
                              place1:
                                  '${orderSelected[2]},\n${orderSelected[3]}',
                              place2:
                                  '${orderSelected[4]}\n${orderSelected[5]}',
                              total: '\$${orderSelected[6]}')
                          : DraggableScrollableSheet(
                              initialChildSize: 0.15,
                              minChildSize: 0.15,
                              maxChildSize: 0.85,
                              builder: (context, scrollController) {
                                return Container(
                                  width: size.width * 1,
                                  height: size.height * 0.6,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15))),
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    controller: scrollController,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: size.width * 1,
                                            height: size.height * 0.06,
                                            decoration: const BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15))),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: size.height * 0.023),
                                              child: Text(
                                                '¡Comunidad 100% Latina!',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize:
                                                        size.height * 0.018,
                                                    color: Colors.white,
                                                    fontFamily: 'Poppins',
                                                    height: 1),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          Text(
                                            'Solicitudes',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: size.height * 0.035,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontFamily: 'Poppins',
                                                height: 1),
                                          ),
                                          ColumnBuilder(
                                              textDirection: TextDirection.ltr,
                                              itemCount: myOrders.length,
                                              itemBuilder: (context, index) {
                                                String fecha = '';
                                                String hora = '';
                                                if (myOrders.isNotEmpty) {
                                                  String info = myOrders[index]
                                                      ['created_at'];
                                                  var sep = info.split('T');
                                                  var sep2 = sep[1].split('.');
                                                  fecha = sep[0];
                                                  hora = sep2[0];
                                                }

                                                return solicitudesViajes(
                                                    size,
                                                    fecha,
                                                    hora,
                                                    '5km',
                                                    myOrders[index]
                                                            ['user_address_from']
                                                        ['address'],
                                                    myOrders[index]
                                                            ['user_address_from']
                                                        ['address_no'],
                                                    myOrders[index]['user_address']
                                                        ['address'],
                                                    myOrders[index]
                                                            ['user_address']
                                                        ['address_no'],
                                                    '\$${myOrders[index]['cost_delivery']}',
                                                    myOrders[index]['state']
                                                        ['value'],
                                                    myOrders[index]['id'],
                                                    LatLng(
                                                        double.parse(myOrders[index]
                                                                ['user_address_from']
                                                            ['latitude']),
                                                        double.parse(myOrders[index]
                                                                ['user_address_from']
                                                            ['longitude'])),
                                                    LatLng(double.parse(myOrders[index]['user_address_from']['latitude']), double.parse(myOrders[index]['user_address_from']['longitude'])),
                                                    LatLng(double.parse(myOrders[index]['user_address']['latitude']), double.parse(myOrders[index]['user_address']['longitude'])),
                                                    '${myOrders[index]['user']['name']}',
                                                    '${myOrders[index]['user']['email']}');
                                              })
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                    ],
                  )
                : !state.isGpsEnable
                    ? _EnableGps(size: size)
                    : _AccessButton(size: size);
          },
        ),
      ),
    );
  }

  Widget solicitudesViajes(
      Size size,
      String date,
      String time,
      String dist,
      String place1,
      String place11,
      String place2,
      String place22,
      String total,
      String estado,
      int id,
      LatLng dirUser,
      LatLng start,
      LatLng end,
      String hisName,
      String hisEmail) {
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.07,
          right: size.width * 0.07,
          top: size.height * 0.02,
          bottom: size.height * 0.02),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: size.height * 0.017,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    height: 1),
              ),
              Text(
                time,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: size.height * 0.017,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    height: 1),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.005,
          ),
          Container(
            height: size.height * 0.28,
            width: size.width * 1,
            color: const Color(0xffF4F2F2),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            'Assets/Images/lineDetalle.png',
                            height: size.height * 0.03,
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Text(
                            'Distancia de recorrido:',
                            style: TextStyle(
                                fontSize: size.height * 0.017,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                height: 1),
                          ),
                        ],
                      ),
                      Text(
                        dist,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: size.height * 0.017,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            height: 1),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.06),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'Assets/Images/lineaSelectViaje.svg',
                        height: size.height * 0.1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$place1,\n$place11',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: size.height * 0.017,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                height: 1),
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Text(
                            '$place2,\n$place22',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: size.height * 0.017,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                height: 1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Total',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: size.height * 0.017,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          height: 1),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    const Icon(Icons.credit_card),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Text(
                      total,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: size.height * 0.021,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          height: 1),
                    ),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          SizedBox(
              height: size.height * 0.06,
              width: size.width * 0.9,
              child: Button(
                  callback: () {
                    buscandoPersona(id);
                    setState(() {
                      orderSelected = [
                        date,
                        time,
                        place1,
                        place11,
                        place2,
                        place22,
                        total,
                        'Recogida',
                        id,
                        start,
                        end,
                        hisName,
                        hisEmail
                      ];
                    });
                    miTimer!.cancel();
                    getData();
                    onSearchPersona(context, dirUser);
                  },
                  height: 0.026,
                  text: 'Aceptar',
                  size: size,
                  color: Colors.black,
                  colorTxt: Colors.white))
        ],
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Debe tener acceso al GPS',
            style: TextStyle(
                fontSize: size.height * 0.017,
                color: Colors.black,
                fontFamily: 'Poppins',
                height: 1),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          SizedBox(
              height: size.height * 0.06,
              width: size.width * 0.8,
              child: Button(
                  callback: () {
                    final gpsBloc = BlocProvider.of<GpsBloc>(context);
                    gpsBloc.askGpsAccess();
                  },
                  height: 0.017,
                  text: 'Solicitar Acceso',
                  size: size,
                  color: Colors.black,
                  colorTxt: Colors.white))
        ],
      ),
    );
  }
}

class _EnableGps extends StatelessWidget {
  const _EnableGps({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Debe habilitar el gps',
        style: TextStyle(
            fontSize: size.height * 0.017,
            color: Colors.black,
            fontFamily: 'Poppins',
            height: 1),
      ),
    );
    // Positioned(
    //     top: -100,
    //     child: Image.asset(
    //       'Assets/Images/backGroundMap.png',
    //       height: size.height * 1,
    //       width: size.width * 1,
    //     ));
  }
}
