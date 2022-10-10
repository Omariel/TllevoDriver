import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tllevo_driver/Api/api_home.dart';
import 'package:tllevo_driver/Blocs/Location/location_bloc.dart';
import 'package:tllevo_driver/Blocs/Map/map_bloc.dart';
import 'package:tllevo_driver/Blocs/Search/search_bloc.dart';
import 'package:tllevo_driver/Pages/Home/cliente_chat.dart';

import '../../Const/const.dart';
import '../../Widget/button.dart';
import 'home.dart';

// ignore: must_be_immutable
class DraggableBottomSheet extends StatefulWidget {
  DraggableBottomSheet(
      {Key? key,
      required this.start,
      required this.end,
      required this.status,
      required this.date,
      required this.dist,
      required this.place1,
      required this.place2,
      required this.time,
      required this.total,
      required this.myEmail,
      required this.tokenUser,
      required this.id,
      required this.hisEmail, 
      required this.hisName})
      : super(key: key);
  String status;
  String date;
  String time;
  String dist;
  String place1;
  String place2;
  String total;
  String myEmail;
  String tokenUser;
  LatLng start;
  LatLng end;
  int id;
  String hisName;
  String hisEmail;
  @override
  State<DraggableBottomSheet> createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  bool llego = false;
  @override
  void initState() {
    if (widget.status == 'Recogida') {
      onSearchPersona(context, widget.start);
    } else {
      llevarPersona(context, widget.start, widget.end);
    }
    widget.status == 'Recogida' ? null : llego = true;
    super.initState();
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

  void llevarPersona(BuildContext context, LatLng start, LatLng end) async {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    // if (result.manual == true) {
    //   //searchBloc.add( OnActivateManualMarkerEvent() );
    //   return;
    // }

    if (start != null) {
      //final destination = await searchBloc.getCoorsStartToEnd(start, end);
      final destination = await searchBloc.getCoorsStartToEnd(start, end);
      await mapBloc.drawRoutePolyline(destination);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return enCamino(size, mapBloc);
  }

  DraggableScrollableSheet enCamino(Size size, mapBloc) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.23,
      maxChildSize: 0.88,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )),
          child: ListView(
              padding: EdgeInsets.zero,
              controller: scrollController,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.01, bottom: size.height * 0.02),
                      child: Container(
                        height: size.height * 0.006,
                        width: size.width * 0.13,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                    Text(
                      llego == false ?
                      'Camino a ${widget.place1}' :
                      'Camino a ${widget.place2}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: size.height * 0.025,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          height: 1),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Text(
                      'Hora de llegada',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: size.height * 0.017,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          height: 1.6),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: size.height * 0.06,
                      width: size.width * 0.8,
                      color: Colors.black,
                      child: Text(
                        '1:12 min',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: size.height * 0.029,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            height: 1),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: SizedBox(
                                    height: size.height * 0.95,
                                    width: size.width * 1.5,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: size.height * 0.06,
                                            ),
                                            Text(
                                              'Elegir ruta',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: size.height * 0.029,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontFamily: 'Poppins',
                                                  height: 1),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.025,
                                            ),
                                            Container(
                                              height: size.height * 0.18,
                                              width: size.width * 0.65,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SvgPicture.asset(
                                                      'Assets/Images/WazeMap.svg'),
                                                  Text(
                                                    'Waze',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.029,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                        fontFamily: 'Poppins',
                                                        height: 1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.03,
                                            ),
                                            Container(
                                              height: size.height * 0.18,
                                              width: size.width * 0.65,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SvgPicture.asset(
                                                      'Assets/Images/GoogleMaps.svg'),
                                                  Text(
                                                    'Google\nMaps',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.029,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                        fontFamily: 'Poppins',
                                                        height: 1),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Positioned(
                                            left: 1,
                                            top: 2,
                                            child: IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon: Icon(
                                                  Icons.cancel_outlined,
                                                  color: Colors.white,
                                                  size: size.height * 0.05,
                                                )))
                                      ],
                                    ),
                                  ),
                                ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height * 0.06,
                        width: size.width * 0.8,
                        color: const Color(0xffCDC8C9),
                        child: Text(
                          'Rutas',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: size.height * 0.029,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              height: 1),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.2,
                      height: size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * 0.12,
                        ),
                        Icon(
                          Icons.location_on_sharp,
                          size: size.height * 0.025,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Text(
                          llego == false ? 
                          widget.place1 :
                          widget.place2,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: size.height * 0.017,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              height: 1),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 1.2,
                      height: size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          // onTap: () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const InfoDriver())),
                          child: SvgPicture.asset(
                            'Assets/Images/simpleFace.svg',
                            height: size.height * 0.07,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                          child: Expanded(
                            child: Text(
                              widget.hisName,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: size.height * 0.021,
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  height: 0),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.03,
                          width: size.width * 0.13,
                          color: const Color(0xffE6E6E6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.black,
                                size: size.height * 0.02,
                              ),
                              Text(
                                '5.0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: size.height * 0.017,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    height: 0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1.2,
                      height: size.height * 0.05,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pago',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: size.height * 0.021,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                height: 1),
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.credit_card,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Text(
                                    widget.total,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: size.height * 0.021,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                        height: 1),
                                  ),
                                ],
                              ),
                              Text(
                                'Tarjeta Visa',
                                textAlign: TextAlign.center,
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
                    Divider(
                      thickness: 1.2,
                      height: size.height * 0.05,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClienteChat(
                                    myEmail: widget.myEmail,
                                    hisEmail: widget.hisEmail,
                                    hisName: widget.hisName,
                                  ))),
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height * 0.05,
                        width: size.width * 0.8,
                        color: const Color.fromARGB(255, 233, 232, 232),
                        child: Text(
                          'Enviar mensaje',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: size.height * 0.021,
                              color: Colors.black54,
                              fontFamily: 'Poppins',
                              height: 0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Home(show: false))),
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height * 0.05,
                        width: size.width * 0.8,
                        color: const Color.fromARGB(255, 233, 232, 232),
                        child: Text(
                          'Llamar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: size.height * 0.021,
                              color: Colors.black54,
                              fontFamily: 'Poppins',
                              height: 0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    SizedBox(
                        height: size.height * 0.05,
                        width: size.width * 0.8,
                        child: Button(
                            callback: () {
                              if (llego == false) {
                                ApiHome()
                                    .llevandoPersona(
                                        widget.tokenUser, widget.id, context)
                                    .then(
                                  (value) {
                                    llevarPersona(
                                        context, widget.start, widget.end);
                                    setState(() {
                                      llego = true;
                                    });
                                  },
                                );
                              } else {
                                ApiHome()
                                    .terminarViaje(
                                        widget.tokenUser, widget.id, context)
                                    .then(
                                  (value) {
                                    if(value == true){
                                       showDialogFinish(size);
                                       mapBloc.clearRoutes();

                                    }
                                  },
                                );
                              }
                            },
                            height: 0.021,
                            text:
                                llego == false ? 'Llegue' : 'Terminar el viaje',
                            size: size,
                            color: Const().black,
                            colorTxt: Colors.white)),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(
                                    show: false,
                                  ))),
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height * 0.05,
                        width: size.width * 0.8,
                        color: const Color.fromARGB(255, 233, 232, 232),
                        child: Text(
                          'Cancelar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: size.height * 0.021,
                              color: Colors.black54,
                              fontFamily: 'Poppins',
                              height: 0),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //     height: size.height * 0.05,
                    //     width: size.width * 0.8,
                    //     child: Button(
                    //         callback: () {
                    //           showDialog(
                    //               context: context,
                    //               builder: (context) => Dialog(
                    //                     shape: RoundedRectangleBorder(
                    //                         borderRadius:
                    //                             BorderRadius.circular(20)),
                    //                     child: SizedBox(
                    //                       height: size.height * 0.62,
                    //                       width: size.width * 0.9,
                    //                       child: Stack(
                    //                         alignment: Alignment.center,
                    //                         children: [
                    //                           Column(
                    //                             crossAxisAlignment:
                    //                                 CrossAxisAlignment.center,
                    //                             mainAxisAlignment:
                    //                                 MainAxisAlignment.start,
                    //                             children: [
                    //                               SizedBox(
                    //                                 height: size.height * 0.06,
                    //                               ),
                    //                               Container(
                    //                                 height: size.height * 0.1,
                    //                                 decoration:
                    //                                     const BoxDecoration(
                    //                                         shape:
                    //                                             BoxShape.circle,
                    //                                         color:
                    //                                             Colors.black),
                    //                                 child: Padding(
                    //                                   padding:
                    //                                       const EdgeInsets.all(
                    //                                           8.0),
                    //                                   child: Icon(
                    //                                     Icons.location_pin,
                    //                                     color: Const().yellow,
                    //                                     size:
                    //                                         size.height * 0.08,
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                               SizedBox(
                    //                                 height: size.height * 0.02,
                    //                               ),
                    //                               Text(
                    //                                 'Compartir viaje',
                    //                                 style: TextStyle(
                    //                                     fontSize:
                    //                                         size.height * 0.025,
                    //                                     color: Colors.black,
                    //                                     fontFamily: 'Poppins',
                    //                                     height: 1),
                    //                               ),
                    //                               SizedBox(
                    //                                 height: size.height * 0.03,
                    //                               ),
                    //                               Container(
                    //                                 height: size.height * 0.1,
                    //                                 decoration:
                    //                                     const BoxDecoration(
                    //                                         shape:
                    //                                             BoxShape.circle,
                    //                                         color:
                    //                                             Colors.black),
                    //                                 child: Center(
                    //                                   child: Text(
                    //                                     '911',
                    //                                     style: TextStyle(
                    //                                       fontSize:
                    //                                           size.height *
                    //                                               0.05,
                    //                                       fontWeight:
                    //                                           FontWeight.bold,
                    //                                       color: Const().yellow,
                    //                                       fontFamily: 'Poppins',
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                               SizedBox(
                    //                                 height: size.height * 0.02,
                    //                               ),
                    //                               Text(
                    //                                 'Llamar al 911',
                    //                                 style: TextStyle(
                    //                                     fontSize:
                    //                                         size.height * 0.025,
                    //                                     color: Colors.black,
                    //                                     fontFamily: 'Poppins',
                    //                                     height: 1),
                    //                               ),
                    //                               SizedBox(
                    //                                 height: size.height * 0.03,
                    //                               ),
                    //                               Container(
                    //                                 height: size.height * 0.1,
                    //                                 decoration:
                    //                                     const BoxDecoration(
                    //                                         shape:
                    //                                             BoxShape.circle,
                    //                                         color:
                    //                                             Colors.black),
                    //                                 child: Padding(
                    //                                     padding:
                    //                                         const EdgeInsets
                    //                                             .all(8.0),
                    //                                     child: Transform.rotate(
                    //                                         angle: pi / 4,
                    //                                         child: Icon(
                    //                                           Icons.add,
                    //                                           color: Const()
                    //                                               .yellow,
                    //                                           size:
                    //                                               size.height *
                    //                                                   0.08,
                    //                                         ))),
                    //                               ),
                    //                               SizedBox(
                    //                                 height: size.height * 0.02,
                    //                               ),
                    //                               Text(
                    //                                 'Cancelar y buscar\notro conductor',
                    //                                 textAlign: TextAlign.center,
                    //                                 style: TextStyle(
                    //                                     fontSize:
                    //                                         size.height * 0.025,
                    //                                     color: Colors.black,
                    //                                     fontFamily: 'Poppins',
                    //                                     height: 1),
                    //                               ),
                    //                             ],
                    //                           ),
                    //                           Positioned(
                    //                               left: 1,
                    //                               top: 2,
                    //                               child: IconButton(
                    //                                   onPressed: () {
                    //                                     Navigator.of(context)
                    //                                         .pop();
                    //                                   },
                    //                                   icon: const Icon(Icons
                    //                                       .cancel_outlined)))
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ));
                    //         },
                    //         height: 0.021,
                    //         text: 'Seguridad',
                    //         size: size,
                    //         color: Const().black,
                    //         colorTxt: Colors.white)),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                  ],
                ),
              ]),
        );
      },
    );
  }

  // DraggableScrollableSheet porAceptar(Size size) {
  //   return DraggableScrollableSheet(
  //     initialChildSize: 0.5,
  //     minChildSize: 0.15,
  //     maxChildSize: 0.85,
  //     builder: (context, scrollController) {
  //       return Container(
  //         decoration: const BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(15),
  //               topRight: Radius.circular(15),
  //             )),
  //         child: ListView(
  //             padding: EdgeInsets.zero,
  //             controller: scrollController,
  //             children: [
  //               Column(
  //                 children: [
  //                   SizedBox(
  //                     height: size.height * 0.015,
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(
  //                         top: size.height * 0.01, bottom: size.height * 0.02),
  //                     child: Container(
  //                       height: size.height * 0.006,
  //                       width: size.width * 0.13,
  //                       decoration: BoxDecoration(
  //                           color: Colors.black,
  //                           borderRadius: BorderRadius.circular(30)),
  //                     ),
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     children: [
  //                       GestureDetector(
  //                         // onTap: () => Navigator.push(
  //                         //     context,
  //                         //     MaterialPageRoute(
  //                         //         builder: (context) => const InfoDriver())),
  //                         child: SvgPicture.asset(
  //                           'Assets/Images/simpleFace.svg',
  //                           height: size.height * 0.07,
  //                         ),
  //                       ),
  //                       Text(
  //                         'Carlos\nEscamilla',
  //                         textAlign: TextAlign.start,
  //                         style: TextStyle(
  //                             fontSize: size.height * 0.021,
  //                             color: Colors.black,
  //                             fontFamily: 'Poppins',
  //                             height: 0),
  //                       ),
  //                       Container(
  //                         height: size.height * 0.03,
  //                         width: size.width * 0.13,
  //                         color: const Color(0xffE6E6E6),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                           children: [
  //                             Icon(
  //                               Icons.star,
  //                               color: Colors.black,
  //                               size: size.height * 0.02,
  //                             ),
  //                             Text(
  //                               '5.0',
  //                               textAlign: TextAlign.center,
  //                               style: TextStyle(
  //                                   fontSize: size.height * 0.017,
  //                                   color: Colors.black,
  //                                   fontFamily: 'Poppins',
  //                                   height: 0),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   Divider(
  //                     thickness: 1.2,
  //                     height: size.height * 0.03,
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(
  //                         left: size.width * 0.07,
  //                         right: size.width * 0.07,
  //                         top: size.height * 0.02,
  //                         bottom: size.height * 0.02),
  //                     child: Column(
  //                       children: [
  //                         Padding(
  //                           padding: EdgeInsets.symmetric(
  //                               horizontal: size.height * 0.02),
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Text(
  //                                 widget.date,
  //                                 textAlign: TextAlign.center,
  //                                 style: TextStyle(
  //                                     fontSize: size.height * 0.017,
  //                                     color: Colors.black,
  //                                     fontFamily: 'Poppins',
  //                                     height: 1),
  //                               ),
  //                               Text(
  //                                 widget.time,
  //                                 textAlign: TextAlign.center,
  //                                 style: TextStyle(
  //                                     fontSize: size.height * 0.017,
  //                                     color: Colors.black,
  //                                     fontFamily: 'Poppins',
  //                                     height: 1),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: size.height * 0.005,
  //                         ),
  //                         Column(
  //                           children: [
  //                             SizedBox(
  //                               height: size.height * 0.02,
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.symmetric(
  //                                   horizontal: size.height * 0.02),
  //                               child: Row(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.end,
  //                                 children: [
  //                                   Text(
  //                                     'Distancia de recorrido:',
  //                                     style: TextStyle(
  //                                         fontSize: size.height * 0.017,
  //                                         color: Colors.black,
  //                                         fontFamily: 'Poppins',
  //                                         height: 1),
  //                                   ),
  //                                   Text(
  //                                     widget.dist,
  //                                     textAlign: TextAlign.center,
  //                                     style: TextStyle(
  //                                         fontSize: size.height * 0.017,
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.w500,
  //                                         fontFamily: 'Poppins',
  //                                         height: 1),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             SizedBox(
  //                               height: size.height * 0.04,
  //                             ),
  //                             Padding(
  //                               padding:
  //                                   EdgeInsets.only(left: size.width * 0.06),
  //                               child: Row(
  //                                 children: [
  //                                   SvgPicture.asset(
  //                                     'Assets/Images/lineaSelectViaje.svg',
  //                                     height: size.height * 0.1,
  //                                     color: Colors.black,
  //                                   ),
  //                                   SizedBox(
  //                                     width: size.width * 0.04,
  //                                   ),
  //                                   Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Text(
  //                                         widget.place1,
  //                                         textAlign: TextAlign.start,
  //                                         style: TextStyle(
  //                                             fontSize: size.height * 0.017,
  //                                             color: Colors.black,
  //                                             fontFamily: 'Poppins',
  //                                             height: 1),
  //                                       ),
  //                                       SizedBox(
  //                                         height: size.height * 0.05,
  //                                       ),
  //                                       Text(
  //                                         widget.place2,
  //                                         textAlign: TextAlign.start,
  //                                         style: TextStyle(
  //                                             fontSize: size.height * 0.017,
  //                                             color: Colors.black,
  //                                             fontFamily: 'Poppins',
  //                                             height: 1),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Divider(
  //                     thickness: 1.2,
  //                     height: size.height * 0.03,
  //                   ),
  //                   Padding(
  //                     padding:
  //                         EdgeInsets.symmetric(horizontal: size.width * 0.11),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           'Pago',
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(
  //                               fontSize: size.height * 0.021,
  //                               color: Colors.black,
  //                               fontFamily: 'Poppins',
  //                               height: 1),
  //                         ),
  //                         Column(
  //                           children: [
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.end,
  //                               children: [
  //                                 const Icon(
  //                                   Icons.credit_card,
  //                                   size: 30,
  //                                 ),
  //                                 SizedBox(
  //                                   width: size.width * 0.02,
  //                                 ),
  //                                 Text(
  //                                   widget.total,
  //                                   textAlign: TextAlign.center,
  //                                   style: TextStyle(
  //                                       fontSize: size.height * 0.021,
  //                                       color: Colors.black,
  //                                       fontWeight: FontWeight.w500,
  //                                       fontFamily: 'Poppins',
  //                                       height: 1),
  //                                 ),
  //                               ],
  //                             ),
  //                             Text(
  //                               'Tarjeta Visa',
  //                               textAlign: TextAlign.center,
  //                               style: TextStyle(
  //                                   fontSize: size.height * 0.017,
  //                                   color: Colors.black,
  //                                   fontFamily: 'Poppins',
  //                                   height: 1),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Divider(
  //                     thickness: 1.2,
  //                     height: size.height * 0.03,
  //                   ),
  //                   GestureDetector(
  //                     onTap: () => Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) => ClienteChat(myEmail: widget.myEmail,))),
  //                     child: Container(
  //                       alignment: Alignment.center,
  //                       height: size.height * 0.05,
  //                       width: size.width * 0.8,
  //                       color: const Color.fromARGB(255, 233, 232, 232),
  //                       child: Text(
  //                         'Enviar mensaje',
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(
  //                             fontSize: size.height * 0.021,
  //                             color: Colors.black54,
  //                             fontFamily: 'Poppins',
  //                             height: 0),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: size.height * 0.025,
  //                   ),
  //                   GestureDetector(
  //                     // onTap: () => Navigator.push(
  //                     //     context,
  //                     //     MaterialPageRoute(
  //                     //         builder: (context) => const Mensajes())),
  //                     child: Container(
  //                       alignment: Alignment.center,
  //                       height: size.height * 0.05,
  //                       width: size.width * 0.8,
  //                       color: const Color.fromARGB(255, 233, 232, 232),
  //                       child: Text(
  //                         'Llamar',
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(
  //                             fontSize: size.height * 0.021,
  //                             color: Colors.black54,
  //                             fontFamily: 'Poppins',
  //                             height: 0),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: size.height * 0.025,
  //                   ),
  //                   SizedBox(
  //                       height: size.height * 0.05,
  //                       width: size.width * 0.8,
  //                       child: Button(
  //                           callback: () async{
  //                             await ApiHome().llevandoPersona(widget.tokenUser, widget.id, context).then((value) {
  //                               value == true ?
  //                             setState(() {
  //                               isEnCamino = true;
  //                             }) : null;

  //                             });
  //                           },
  //                           height: 0.021,
  //                           text: 'Voy en camino',
  //                           size: size,
  //                           color: Const().black,
  //                           colorTxt: Colors.white)),
  //                   SizedBox(
  //                     height: size.height * 0.025,
  //                   ),
  //                   GestureDetector(
  //                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
  //                         builder: (context) => Home(show: false))),
  //                     child: Container(
  //                       alignment: Alignment.center,
  //                       height: size.height * 0.05,
  //                       width: size.width * 0.8,
  //                       color: const Color.fromARGB(255, 233, 232, 232),
  //                       child: Text(
  //                         'Cancelar',
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(
  //                             fontSize: size.height * 0.021,
  //                             color: Colors.black54,
  //                             fontFamily: 'Poppins',
  //                             height: 0),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: size.height * 0.05,
  //                   )
  //                 ],
  //               ),
  //             ]),
  //       );
  //     },
  //   );
  // }
  Future showDialogFinish(Size size) {
    return showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: SizedBox(
                height: size.height * 0.52,
                width: size.width * 0.9,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.06,
                        ),
                        Text(
                          '¿Qué tal estuvo tu viaje?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: size.height * 0.025,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              height: 1),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        SvgPicture.asset(
                          'Assets/Images/simpleFace.svg',
                          height: size.height * 0.085,
                        ),
                        SizedBox(
                          height: size.height * 0.035,
                        ),
                        Text(
                          widget.hisName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: size.height * 0.021,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              height: 1),
                        ),
                        SizedBox(
                          height: size.height * 0.035,
                        ),
                        Text(
                          'Califica tu viaje',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: size.height * 0.025,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              height: 1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.black26,
                              size: size.height * 0.06,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.black26,
                              size: size.height * 0.06,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.black26,
                              size: size.height * 0.06,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.black26,
                              size: size.height * 0.06,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.black26,
                              size: size.height * 0.06,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        SizedBox(
                            height: size.height * 0.06,
                            width: size.width * 0.7,
                            child: Button(
                                callback: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Home(show: false)));
                                },
                                height: 0.021,
                                text: 'Terminar viaje',
                                size: size,
                                color: Colors.black,
                                colorTxt: Colors.white)),
                      ],
                    ),
                    Positioned(
                      top: size.height * 0.18,
                      child: Container(
                        height: size.height * 0.03,
                        width: size.width * 0.13,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.star_rate_rounded,
                              color: Colors.white,
                              size: size.height * 0.02,
                            ),
                            Text(
                              '5.0',
                              style: TextStyle(
                                fontSize: size.height * 0.017,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
