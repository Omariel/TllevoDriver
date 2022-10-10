import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tllevo_driver/Api/api_login.dart';
import 'package:tllevo_driver/Pages/Inicio/Login/login.dart';
import 'package:tllevo_driver/Pages/Inicio/term&cond.dart';
import 'package:tllevo_driver/Widget/button.dart';
import '../../Const/const.dart';

// ignore: must_be_immutable
class Registro extends StatefulWidget {
  Registro({Key? key, required this.name}) : super(key: key);
  String name;
  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  bool _passwordVisible = false;
  TextEditingController controllerName = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  final TextEditingController controller = TextEditingController();
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
          ListView(children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              'Para iniciar, ingresa\ntus datos',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: size.height * 0.035,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  height: 1),
            ),
            SizedBox(
              height: size.height * 0.03,
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
              height: size.height * 0.05,
            ),
            Form(
              key: keyForm,
              child: Column(
                children: [
                  SizedBox(
                    //height: size.height * 0.099,
                    width: size.width * 0.8,
                    child: TextFormField(
                      controller: controllerName,
                      cursorColor: Colors.black,
                      validator: (value) {
                        String pattern = r'(^[a-zA-ZÀ-ÿ\u00f1\u00d1]+(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]+$)';
                        RegExp regExp = RegExp(pattern);
                        if (value!.isEmpty) {
                          return "El nombre es necesario";
                        } else if (!regExp.hasMatch(value)) {
                          return "El nombre debe de ser a-z y A-Z";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: 'Nombre',
                          hintStyle: TextStyle(fontSize: 20),
                          filled: true,
                          fillColor: Color.fromARGB(255, 233, 232, 232),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5))),
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.1, right: size.width * 0.1),
                    child: InternationalPhoneNumberInput(
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          print(p0);
                          return 'Debe ingresar un numero de telefono';
                        }
                      },
                      hintText: 'Número de teléfono móvil',
                      onInputChanged: (PhoneNumber number) {
                        this.number = number;
                      },
                      onInputValidated: (bool value) {},
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: const TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: controller,
                      formatInput: false,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputBorder: const OutlineInputBorder(),
                      onSaved: (PhoneNumber number) {},
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
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
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    //height: 50,
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
                    height: size.height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: size.width * 0.3),
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => Login())),
                      child: Text(
                        '¿Ya tienes una cuenta?',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: size.height * 0.021,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            height: 0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.047,
                  ),
                  SizedBox(
                      height: size.height * 0.06,
                      width: size.width * 0.8,
                      child: Button(
                        callback: () {
                          if (keyForm.currentState!.validate()) {
                            Api().signUp(
                                controllerName.text,
                                controllerEmail.text,
                                controllerPassword.text,
                                number.phoneNumber.toString(),
                                context);
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
