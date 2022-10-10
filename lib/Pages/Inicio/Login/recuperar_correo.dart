import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tllevo_driver/Api/api_login.dart';
import 'package:tllevo_driver/Pages/Inicio/Login/recuperar_password.dart';

import '../../../Const/const.dart';
import '../../../Widget/button.dart';


// ignore: must_be_immutable
class RecuperarCorreo extends StatefulWidget {
  RecuperarCorreo({Key? key}) : super(key: key);
  @override
  State<RecuperarCorreo> createState() => _RecuperarCorreoState();
}

class _RecuperarCorreoState extends State<RecuperarCorreo> {
  bool _passwordVisible = false;
  TextEditingController controllerEmail = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
            'Ingresa tu Correo',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: size.height * 0.035,
                color: Colors.black,
                fontFamily: 'Poppins',
                height: 1),
          ),
        ),
        // Positioned(
        //   top: size.height * 0.26,
        //   left: size.width * 0.05,
        //   right: size.width * 0.05,
        //   child: Text(
        //     'Los conductores confirmarán que eres tú al llegar',
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //         fontSize: size.height * 0.025,
        //         color: Colors.black87,
        //         fontFamily: 'Poppins'),
        //   ),
        // ),
        Positioned(
            left: size.width * 0.37,
            top: size.height * 0.36,
            child: SvgPicture.asset(
              'Assets/Images/face.svg',
              width: size.width * 0.35,
            )),
        Positioned(
          top: size.height * 0.53,
          child: Form(
            key: keyForm,
            child: Column(
              children: [
                SizedBox(
                  //height: 50,
                  width: size.width * 0.8,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    validator: (value) {
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regExp = RegExp(pattern);
                      if (value!.isEmpty) {
                        return "El correo es necesario";
                      } else if (!regExp.hasMatch(value)) {
                        return "Correo invalido";
                      } else {
                        return null;
                      }
                    },
                    controller: controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: 'Correo',
                        hintStyle: TextStyle(fontSize: 20),
                        filled: true,
                        fillColor: Color.fromARGB(255, 233, 232, 232),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5))),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.25,
                ),
                SizedBox(
              height: size.height * 0.06,
              width: size.width * 0.8,
              child: Button(
                callback: () {
                  if (keyForm.currentState!.validate()) {
                   Api().forgotPassword(controllerEmail.text, '', '', true, context);

                    }
                },
                height: 0.025,
                text: 'Siguiente',
                size: size,
                color: Const().black,
                colorTxt: Colors.white,
              )),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
