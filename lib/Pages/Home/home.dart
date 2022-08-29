import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tllevo_driver/Pages/Cuenta/cuenta.dart';
import 'package:tllevo_driver/Pages/Home/selected_viaje.dart';
import 'package:tllevo_driver/Widget/button.dart';


// ignore: must_be_immutable
class Home extends StatefulWidget {
  Home({Key? key, required this.show}) : super(key: key);
  bool show;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isDragabble = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Stack(children: [
          Positioned(
              top: -100,
              child: Image.asset(
                'Assets/Images/backGroundMap.png',
                height: size.height * 1,
                width: size.width * 1,
              )),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Cuenta(
                                  tokenUser: 'tokenUser',
                                )));
                  },
                  child: const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 30,
                  )),
            ),
          ),
          isDragabble ?
          DraggableBottomSheet(date: '7/5/22', time: '3:54 p.m', dist: '5km', place1: '1 World Way, Los Angeles, CA 90045,\nEstados Unidos', place2: 'Renaissance Los Angeles\nAirport Hotel', total: '\$43.58') :
          Positioned(
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: SizedBox(
                    height: 35,
                    width: 35,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          primary: Colors.white,
                          elevation: 3,
                          //maximumSize: Size(50, 50),
                          //minimumSize: Size(1, 30), //////// HERE
                        ),
                        onPressed: () {},
                        child: const Icon(
                          Icons.my_location,
                          color: Colors.black,
                        )),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  width: size.width * 1,
                  height: size.height * 0.6,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: Column(
                    children: [
                      Container(
                        width: size.width * 1,
                        height: size.height * 0.06,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height * 0.023),
                          child: Text(
                            '¡Comunidad 100% Latina!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: size.height * 0.018,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                height: 1),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
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
                        solicitudesViajes(size, '7/5/22', '3:54 p.m', '5km', '1 World Way, Los Angeles, CA 90045,\nEstados Unidos', 'Renaissance Los Angeles\nAirport Hotel', '\$43.58'),
                        solicitudesViajes(size, '7/5/22', '3:54 p.m', '5km', '1 World Way, Los Angeles, CA 90045,\nEstados Unidos', 'Renaissance Los Angeles\nAirport Hotel', '\$43.58')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget solicitudesViajes(Size size, String date, String time, String dist, String place1, String place2, String total) {
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.07,
          right: size.width * 0.07,
          top: size.height * 0.02,
          bottom: size.height*0.02),
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
          SizedBox(height: size.height*0.005,),
          Container(
            height: size.height * 0.28,
            width: size.width * 1,
            color: const Color(0xffF4F2F2),
            child: Column(
              children: [
                SizedBox(height: size.height*0.02,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset('Assets/Images/lineDetalle.png', height: size.height*0.03,),
                          SizedBox(width: size.width*0.03,),
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
                SizedBox(height: size.height*0.04,),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.06),
                  child: Row(
                    children: [

                          SvgPicture.asset('Assets/Images/lineaSelectViaje.svg',height: size.height*0.1, color: Colors.black,),
                      SizedBox(width: size.width*0.04,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                       Text(
                            place1,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: size.height * 0.017,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                height: 1),
                          ),
                          SizedBox(height: size.height*0.05,),
                          Text(
                            place2,
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
                SizedBox(height: size.height*0.03,),
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
                          SizedBox(width: size.width*0.02,),
                          const Icon(Icons.credit_card),
                          SizedBox(width: size.width*0.02,),
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
                SizedBox(width: size.width*0.05,),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: size.height*0.03,),
          SizedBox(
            height: size.height*0.06,
            width: size.width*0.9,
            child: Button(callback: (){
              setState(() {
                isDragabble = true;
              });
            }, height: 0.026, text: 'Aceptar', size: size, color: Colors.black, colorTxt: Colors.white))
        ],
      ),
    );
  }
}
