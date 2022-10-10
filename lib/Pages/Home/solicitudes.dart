import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tllevo_driver/Api/api_home.dart';
import 'package:tllevo_driver/Widget/column_builder.dart';
import '../../Widget/button.dart';

// ignore: must_be_immutable
class DraggableBottomSheetSolicitudes extends StatefulWidget {
  VoidCallback callback;
  List myOrders;
  DraggableBottomSheetSolicitudes({required this.callback, required this.myOrders});
  @override
  State<DraggableBottomSheetSolicitudes> createState() =>
      _DraggableBottomSheetSolicitudesState();
}

class _DraggableBottomSheetSolicitudesState
    extends State<DraggableBottomSheetSolicitudes> {
  String? tokenUser;
  @override
  void initState() {
    super.initState();
  }

  void buscandoPersona(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenUser = prefs.getString('tokenUser')!;
    // ignore: use_build_context_synchronously
    ApiHome().buscandoPersona(tokenUser!, id, context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DraggableScrollableSheet(
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
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
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
                      itemCount: widget.myOrders.length,
                      itemBuilder: (context, index) {
                        String fecha = '';
                        String hora = '';
                        if (widget.myOrders.isNotEmpty) {
                          String info = widget.myOrders[index]['created_at'];
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
                            '${widget.myOrders[index]['user_address_from']['address']},\n${widget.myOrders[index]['user_address_from']['address_no']}',
                            '${widget.myOrders[index]['user_address']['address']},\n${widget.myOrders[index]['user_address']['address_no']}',
                            '\$${widget.myOrders[index]['cost_delivery']}',
                            widget.myOrders[index]['id']);
                      })
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget solicitudesViajes(Size size, String date, String time, String dist,
      String place1, String place2, String total, int id) {
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
                            place1,
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
                    widget.callback();
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
