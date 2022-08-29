import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tllevo_driver/Const/const.dart';
import 'package:tllevo_driver/Pages/Cuenta/Viajes/viajes.dart';
import 'package:tllevo_driver/Pages/Cuenta/soporte_chat.dart';
import 'package:tllevo_driver/Pages/Inicio/term&cond.dart';
import 'package:tllevo_driver/Pages/Inicio/welcome.dart';
import 'package:tllevo_driver/Widget/button.dart';

import 'Configuracion/Configuracion.dart';
class Cuenta extends StatefulWidget {
  Cuenta({Key? key, required this.tokenUser}) : super(key: key);
  String tokenUser;

  @override
  State<Cuenta> createState() => _CuentaState();
}

class _CuentaState extends State<Cuenta> {
  bool conectado = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: size.height * 0.05,
            left: size.width * 0.02,
            child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.black,
                  size: 30,
                )),
          ),
          Positioned(
              top: size.height * 0.15,
              left: size.width * 0.12,
              child: SvgPicture.asset(
                'Assets/Images/simpleFace.svg',
                height: size.height * 0.1,
              )),
          Positioned(
            top: size.height * 0.265,
            left: size.width * 0.12,
            child: Text(
              'Ricardo lópez',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: size.height * 0.04,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  height: 1.1),
            ),
          ),
          Positioned(
              top: size.height * 0.18,
              right: size.width * 0.12,
              child: Container(
                height: size.height * 0.05,
                width: size.width * 0.21,
                color: const Color.fromARGB(255, 233, 232, 232),
                child: Row(
                  children: [
                    SizedBox(width: size.width * 0.01),
                    const Icon(
                      Icons.star,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.01, left: size.width * 0.015),
                      child: Text(
                        '5.0',
                        style: TextStyle(
                            fontSize: size.height * 0.021,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            height: 1),
                      ),
                    ),
                  ],
                ),
              )),
              Positioned(
                top: size.height*0.33,
                left: size.width*0.12,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                            'Placa: 2SAM123',
                            style: TextStyle(
                                fontSize: size.height * 0.021,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                height: 1),
                          ),
                  Text(
                            'Viajes realizado: 1022 viajes',
                            style: TextStyle(
                                fontSize: size.height * 0.021,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                height: 1),
                          ),
                ],
              )),
              Positioned(
                left: size.width*0.1,
                top: size.height*0.4,
                child: SizedBox(
                  height: size.height*0.06,
                  width: size.width*0.8,
                  child: Button(callback: (){
                    setState(() {
                      conectado = !conectado;
                    });
                  }, height: 0.021, text: conectado ? 'Desonectarme' : 'Conectarme', size: size, color: conectado ? Colors.black : Const().yellow, colorTxt: conectado ? Colors.white : Colors.black))),
          Positioned(
              top: size.height * 0.52,
              right: size.width * 0.12,
              left: size.width * 0.12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Viajes())),
                    child: Container(
                      height: size.height * 0.17,
                      width: size.width * 0.36,
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'Assets/Images/carSimple.svg',
                            width: size.width * 0.3,
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            'Viajes',
                            style: TextStyle(
                                fontSize: size.height * 0.017,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                height: 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const Configuracion()))),
                    child: Container(
                      height: size.height * 0.17,
                      width: size.width * 0.36,
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'Assets/Images/configuracion.svg',
                            width: size.width * 0.15,
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            'Configuración',
                            style: TextStyle(
                                fontSize: size.height * 0.017,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                height: 1),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
          Positioned(
              top: size.height * 0.77,
              left: size.width * 0.13,
              right: size.width * 0.12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SoporteChat(
                                  ))),
                      child: Text(
                        'Soporte',
                        style: TextStyle(
                            fontSize: size.height * 0.017,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            height: 1),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    height: size.height * 0.03,
                    color: const Color(0xffB3B3B3),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TermCond(
                                    login: false,
                                  ))),
                      child: Text(
                        'Legal',
                        style: TextStyle(
                            fontSize: size.height * 0.017,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            height: 1),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    height: size.height * 0.03,
                    color: const Color(0xffB3B3B3),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Welcome()));
                      },
                      child: Text(
                        'Cerrar sesión',
                        style: TextStyle(
                            fontSize: size.height * 0.017,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            height: 1),
                      ),
                    ),
                  ),
                  Divider(
                      thickness: 1.0,
                      height: size.height * 0.03,
                      color: const Color(0xffB3B3B3))
                ],
              ))
        ],
      ),
    );
  }
}
