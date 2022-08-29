import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tllevo_driver/Pages/Home/home.dart';
import 'package:tllevo_driver/Pages/Inicio/Login/recuperar_correo.dart';
import 'package:tllevo_driver/Widget/button.dart';

import '../../../Const/const.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passwordVisible = false;
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ListView( children: [
             SizedBox(
              height: size.height * 0.15,
            ),
            Text(
              'Ingresa tu cuenta',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: size.height * 0.035,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  height: 1),
            ),
            SizedBox(
              height: size.height * 0.075,
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
            SvgPicture.asset(
              'Assets/Images/face.svg',
              width: size.width * 0.35,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),

            Form(
              key: keyForm,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height*0.099,
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
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    height: size.height*0.099,
                    width: size.width * 0.8,
                    child: TextFormField(
                      controller: controllerPassword,
                      validator: (value) {
                        if (value!.length < 7) {
                          return 'Ingresa al menos 7 caracteres';
                        } else {
                          return null;
                        }
                      },
                      obscureText: !_passwordVisible,
                      enableSuggestions: false,
                      autocorrect: false,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          hintText: 'Contraseña',
                          hintStyle: const TextStyle(fontSize: 20),
                          suffixIcon: IconButton(
                              onPressed: (() {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              }),
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black54,
                              )),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 233, 232, 232),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5))),
                      style: Theme.of(context).textTheme.headline6,
                      //keyboardType: TextInputType.name,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: size.width * 0.275),
                    child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> RecuperarCorreo()));
              },
              child: Text(
                'Recuperar contraseña',
                textAlign: TextAlign.center,
                style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: size.height * 0.023,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      height: 1),
              ),
            ),
                  ),
                  SizedBox(
                    height: size.height * 0.105,
                  ),
                  SizedBox(
                height: size.height * 0.06,
                width: size.width * 0.8,
                child: Button(
                  callback: () {
                    if (keyForm.currentState!.validate()) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(show: false)));

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
            
          ]),
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
        ],
      ),
    );
  }
}
