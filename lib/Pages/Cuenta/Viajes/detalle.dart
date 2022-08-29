import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tllevo_driver/Const/const.dart';
import 'package:tllevo_driver/Pages/Cuenta/soporte_chat.dart';
import 'package:tllevo_driver/Widget/button.dart';

class Detalle extends StatelessWidget {
  String date, price, code, img;
  Detalle(
      {Key? key,
      required this.date,
      required this.code,
      required this.img,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Container(
                width: size.width * 1,
                height: size.height * 0.12,
                color: Const().yellow,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: size.height * 0.04,
                      left: size.width * 0.02,
                      child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                    ),
                    Positioned(
                      top: size.height * 0.06,
                      child: Text(
                        'Detalle',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: size.height * 0.041,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            height: 1.1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: size.width * 1,
                  height: size.height * 0.26,
                  child: Image.asset(
                    img,
                    fit: BoxFit.cover,
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.03,
                      left: size.width * 0.1,
                      right: size.width * 0.1),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              date,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: size.height * 0.021,
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  height: 1.1),
                            ),
                            Text(
                              price,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: size.height * 0.021,
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  height: 1),
                            ),
                          ],
                        ),
                        Text(
                          code,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: size.height * 0.021,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ])),
            ],
          ),
          Positioned(
              left: size.width * 0.12,
              top: size.height * 0.49,
              child: Image.asset('Assets/Images/lineDetalle.png')),
          Positioned(
            left: size.width * 0.22,
            right: size.width * 0.1,
            top: size.height * 0.485,
            child: Text(
              '1 World Way, Los Angeles, CA \n90045, Estados Unidos',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: size.height * 0.017,
                color: Colors.black,
                height: 1.1,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.35,
            right: size.width * 0.1,
            top: size.height * 0.575,
            child: Text(
              'Renaissance Los Angeles Airport Hotel',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: size.height * 0.017,
                color: Colors.black,
                height: 1.1,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Positioned(
            top: size.height *0.66,
            left: size.width*0.1,
            right: size.width*0.1,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('Assets/Images/simpleFace.svg', height: size.height*0.05,),
                        SizedBox(width: size.width*0.03,),
                        Text(
                'Pasajero\nCarlos Escamilla',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: size.height * 0.017,
                  color: Colors.black,
                  height: 1.1,
                  fontFamily: 'Poppins',
                ),
              ),
                      ],
                    ),
                    Row(
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.black,
                        size: 17,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.black,
                        size: 17,
                      ),
                      Icon(
                        Icons.star,
                        size: 17,
                        color: Colors.black,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.black,
                        size: 17,
                      ),
                      Icon(
                        Icons.star,
                        size: 17,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: size.height*0.75,
            child: SizedBox(
              width: size.width*0.8,
              child: Button(callback: (){
                Navigator.of(context).pop();
              }, height: 0.021, text: 'Aceptar', size: size, color: Const().black, colorTxt: Colors.white,))),
          Positioned(
            top: size.height*0.88,
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const SoporteChat())),
              child: Text(
                'Soporte',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w400,
                  fontSize: size.height * 0.017,
                  color: Colors.black,
                  height: 1.1,
                  fontFamily: 'Poppins',
                ),
              ),
            ))
        ],
      ),
    );
  }
}
