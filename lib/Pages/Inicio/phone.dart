import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tllevo_driver/Api/api_login.dart';
import 'package:tllevo_driver/Widget/button.dart';

import '../../Const/const.dart';

// ignore: must_be_immutable
class Phone extends StatelessWidget {
  Phone(
      {Key? key,
      required this.name,
      required this.email,
      required this.password,
      });
  late String name, email, password;
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  final TextEditingController controller = TextEditingController();
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
            'Ingrese su número de teléfono móvil',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: size.height * 0.035,
                color: Colors.black,
                fontFamily: 'Poppins',
                height: 1),
          ),
        ),
        Positioned(
          top: size.height * 0.3,
          left: size.width * 0.05,
          right: size.width * 0.05,
          child: Text(
            'Te enviaremos un mensaje de texto para verificar tu télefono',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: size.height * 0.025,
                color: Colors.black87,
                fontFamily: 'Poppins'),
          ),
        ),
        Positioned(
          top: size.height * 0.5,
          left: size.width * 0.05,
          right: size.width * 0.05,
          child: Column(
            children: [
              Form(
                key: keyForm,
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
                height: size.height * 0.28,
              ),
              SizedBox(
                  height: size.height * 0.06,
                  width: size.width * 0.8,
                  child: Button(
                    callback: () {
                      if (keyForm.currentState!.validate()) {
                             Api().forgotPassword(email, password,
                                number.phoneNumber.toString(), false, context);
                           
                      }
                    },
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=> const ConfirmCode())),

                    height: 0.025,
                    text: 'Siguiente',
                    size: size, color: Const().black, colorTxt: Colors.white,
                  ))
            ],
          ),
        ),
      ]),
    );
  }
}
