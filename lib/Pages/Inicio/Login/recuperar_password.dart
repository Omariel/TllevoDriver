import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tllevo_driver/Api/api_login.dart';

import '../../../Const/const.dart';
import '../../../Widget/button.dart';

// ignore: must_be_immutable
class RecuperarPassword extends StatefulWidget {
  RecuperarPassword({Key? key, required this.id}) : super(key: key);
  String id;
  @override
  State<RecuperarPassword> createState() => _RecuperarPasswordState();
}

class _RecuperarPasswordState extends State<RecuperarPassword> {
  bool _passwordVisible = false;
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerPasswordConfirm = TextEditingController();
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
            'Ingresa tu nueva Contraseña',
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
                  height: size.height * 0.099,
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
                  height: size.height * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.099,
                  width: size.width * 0.8,
                  child: TextFormField(
                    controller: controllerPasswordConfirm,
                    validator: (value) {
                      if (controllerPassword.text !=
                          controllerPasswordConfirm.text) {
                        return 'Las contraseñas no coinciden';
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
                  height: size.height * 0.11,
                ),
                SizedBox(
                    height: size.height * 0.06,
                    width: size.width * 0.8,
                    child: Button(
                      callback: () {
                        if (keyForm.currentState!.validate()) {
                          Api().resetPassword(widget.id,
                              controllerPasswordConfirm.text, context);
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
