// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tllevo_driver/Api/api_login.dart';
import 'package:tllevo_driver/Widget/button.dart';

import '../../Const/const.dart';

class ConfirmCode extends StatelessWidget {
  ConfirmCode(
      {Key? key, required this.code, required this.id, required this.numero,
      required this.contrasena, required this.correo})
      : super(key: key);
  String code, numero, correo, contrasena;
  int id;
  TextEditingController num1 = TextEditingController();
  TextEditingController num2 = TextEditingController();
  TextEditingController num3 = TextEditingController();
  TextEditingController num4 = TextEditingController();
  TextEditingController num5 = TextEditingController();
  TextEditingController num6 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Stack(alignment: Alignment.topCenter, children: [
          Positioned(
            top: size.height * 0.05,
            left: size.width * 0.02,
            child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
          ),
          Positioned(
            top: size.height * 0.2,
            left: size.width * 0.1,
            right: size.width * 0.1,
            child: Text(
              'Ingresa el código de 6 dígitos que se envió al $numero',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: size.height * 0.035,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  height: 1),
            ),
          ),
          Positioned(
              top: size.height * 0.37,
              child: Form(
                  child: Row(
                children: [
                  SizedBox(
                    height: size.height*0.07,
                    width: size.width*0.14,
                    child: TextFormField(
                      controller: num1,
                      onChanged: ((value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 233, 232, 232),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5))),
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  SizedBox(
                     height: size.height*0.07,
                    width: size.width*0.14,
                    child: TextFormField(
                      controller: num2,
                      onChanged: ((value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 233, 232, 232),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5))),
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  SizedBox(
                    height: size.height*0.07,
                    width: size.width*0.14,
                    child: TextFormField(
                      controller: num3,
                      onChanged: ((value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        } 
                      }),
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 233, 232, 232),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5))),
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  SizedBox(
                     height: size.height*0.07,
                    width: size.width*0.14,
                    child: TextFormField(
                      controller: num4,
                      onChanged: ((value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        } 
                      }),
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 233, 232, 232),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5))),
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  SizedBox(
                    height: size.height*0.07,
                    width: size.width*0.14,
                    child: TextFormField(
                      controller: num5,
                      onChanged: ((value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        } 
                      }),
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 233, 232, 232),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5))),
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  SizedBox(
                   height: size.height*0.07,
                    width: size.width*0.14,
                    child: TextFormField(
                      controller: num6,
                      onChanged: ((value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        } 
                      }),
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 233, 232, 232),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5))),
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              ))),
          Positioned(
            top: size.height * 0.5,
            left: size.width * 0.1,
            right: size.width * 0.1,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Const().snackBarOthers(context, 'Su código es: $code');
                  },
                  child: Text(
                    'Enviar nuevamente el código',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: size.height * 0.023,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        height: 1),
                  ),
                ),
                SizedBox(height: size.height*0.02,),
          SizedBox(
              height: size.height * 0.06,
              width: size.width * 0.8,
              child: Button(
                callback: () => print('funciona'),
                height: 0.021,
                text: 'Iniciar sesión con tu cuenta',
                size: size,
                color: Const().black,
                colorTxt: Colors.white,
              )),
                SizedBox(height: size.height*0.255,),
          SizedBox(
              height: size.height * 0.06,
              width: size.width * 0.8,
              child: Button(
                callback: () {
                  String codeEnter = num1.text + num2.text + num3.text + num4.text + num5.text + num6.text;
                  if (codeEnter.length < 6) {
                    Const().snackBarErrorSuccefull(context, 'Ingresa los 6 dígitos', Colors.red);
                  } else {
                    Api().verifyCode(codeEnter, id.toString(), correo, contrasena, context);
                  }
                },
                height: 0.025,
                text: 'Siguiente',
                size: size,
                color: Const().black,
                colorTxt: Colors.white,
              ))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
