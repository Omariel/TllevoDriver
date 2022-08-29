import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tllevo_driver/Const/const.dart';
import 'package:tllevo_driver/Widget/button.dart';

class Configuracion extends StatelessWidget {
  const Configuracion ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: size.width * 1,
            height: size.height * 0.17,
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
                  top: size.height * 0.09,
                  child: Text(
                    'Configuración',
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
            height: size.height * 0.05,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.1, right: size.width * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('Assets/Images/simpleFace.svg', height: size.height*0.13,),
          SizedBox(
            height: size.height * 0.1,
          ),
                Container(
                height: size.height * 0.04,
                width: size.width * 0.8,
                color: const Color.fromARGB(255, 233, 232, 232),
                child:  Padding(
                  padding:  EdgeInsets.only(left:size.width*0.06, top: size.height*0.01),
                  child: Text(
                      'Ricardo',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: size.height * 0.019,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          height: 1.1),
                    ),
                ),
              ),
          SizedBox(
            height: size.height * 0.01,
          ),
                Container(
                height: size.height * 0.04,
                width: size.width * 0.8,
                color: const Color.fromARGB(255, 233, 232, 232),
                child:  Padding(
                  padding:  EdgeInsets.only(left:size.width*0.06, top: size.height*0.01),
                  child: Text(
                      'López',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: size.height * 0.019,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          height: 1.1),
                    ),
                ),
              ),
          SizedBox(
            height: size.height * 0.01,
          ),
                Container(
                height: size.height * 0.04,
                width: size.width * 0.8,
                color: const Color.fromARGB(255, 233, 232, 232),
                child:  Padding(
                  padding:  EdgeInsets.only(left:size.width*0.06, top: size.height*0.01),
                  child: Text(
                      'Ricardo.manzano@tllevo.com',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: size.height * 0.019,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          height: 1.1),
                    ),
                ),
              ),
          SizedBox(
            height: size.height * 0.01,
          ),
                Container(
                height: size.height * 0.04,
                width: size.width * 0.8,
                color: const Color.fromARGB(255, 233, 232, 232),
                child:  Padding(
                  padding:  EdgeInsets.only(left:size.width*0.06, top: size.height*0.01),
                  child: Text(
                      '+1 011 535-0353',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: size.height * 0.019,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          height: 1.1),
                    ),
                ),
              ),
          SizedBox(
            height: size.height * 0.01,
          ),
                Container(
                height: size.height * 0.04,
                width: size.width * 0.8,
                color: const Color.fromARGB(255, 233, 232, 232),
                child:  Padding(
                  padding:  EdgeInsets.only(left:size.width*0.06, top: size.height*0.01),
                  child: Text(
                      'Placa  2SAM123',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: size.height * 0.019,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          height: 1.1),
                    ),
                ),
              ),
          SizedBox(height: size.height*0.18,),
          Button(callback: (){}, height: 0.021, text: 'Guardar', size: size, color: Const().black, colorTxt: Colors.white,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
