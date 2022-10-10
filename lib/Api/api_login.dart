import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tllevo_driver/Pages/Inicio/Login/recuperar_password.dart';
import 'package:tllevo_driver/Pages/Inicio/confirmCode.dart';
import 'package:tllevo_driver/Pages/Inicio/phone.dart';
import 'package:tllevo_driver/Pages/Inicio/welcome.dart';

import '../Const/const.dart';
import '../Models/models.dart';
import '../Pages/Home/home.dart';
import '../Pages/Inicio/term&cond.dart';

class Api {
  Future<void> signUp(String name, String email, String password, String phone,
      BuildContext context) async {
    var response = await http.post(
        Uri.parse('http://apptllevo.com:8089/api/auth/client/signup'),
        body: ({
          "name": name,
          "email": email,
          "password": password,
          "phone": phone
        }));
    if (response.statusCode == 200) {
      SignUpModel message = SignUpModel.fromJson(jsonDecode(response.body));
      bool success = SignUpModel.fromJson(jsonDecode(response.body)).success;
      if (message.message == 'El campo correo ya está en uso.') {
        // ignore: use_build_context_synchronously
        Const().snackBarErrorSuccefull(
            context, 'El correo ya está registrado', Colors.red);
      } else if (success == true) {
        findCode(message.id, context, phone, email, password, false);
      }
    } else {
      // ignore: use_build_context_synchronously
      Const().snackBarErrorSuccefull(context,
          'Ha ocurrido un error, por favor intentelo nuevamente', Colors.red);
    }
  }

  Future<void> findCode(int id, BuildContext context, String numero,
      String email, String password, bool isLogin) async {
    var response = await http.get(
        Uri.parse('http://apptllevo.com:8089/api/auth/verify-code/find/$id'));
    if (response.statusCode == 200) {
      String code = FindCode.fromJson(jsonDecode(response.body)).code;
      //ignore: use_build_context_synchronously
      isLogin
          ? null
          : Const().snackBarErrorSuccefull(
              context, 'Se ha registrado exitosamente!', Colors.green);
      // ignore: use_build_context_synchronously
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmCode(
                      code: code,
                      id: id,
                      numero: numero,
                      correo: email,
                      contrasena: password,
                    )));
      });
      // ignore: use_build_context_synchronously
      Const().snackBarOthers(context, 'Su codigo es: $code');
    }
  }

  Future<void> verifyCode(String code, String id, String email, String password,
      BuildContext context) async {
    var response = await http.post(
        Uri.parse('http://apptllevo.com:8089/api/auth/verify-code'),
        body: ({"code": code, "user_id": id}));
    if (response.statusCode == 200) {
      VerifyCode message = VerifyCode.fromJson(jsonDecode(response.body));
      bool success = VerifyCode.fromJson(jsonDecode(response.body)).success;
      if (message.message == 'Error, verificar código de usuario') {
        // ignore: use_build_context_synchronously
        Const().snackBarErrorSuccefull(
            context, 'El código es incorrecto', Colors.red);
      } else if (message.message == 'Error, Código caducado') {
        // ignore: use_build_context_synchronously
        Const().snackBarErrorSuccefull(
            context, 'El código ha caducado', Colors.red);
      } else if (success == true) {
        // ignore: use_build_context_synchronously
        Const().snackBarErrorSuccefull(
            context, 'Se ha verificado exitosamente!', Colors.green);
        logIn(email, password, false, context);
      }
    } else {
      // ignore: use_build_context_synchronously
      Const().snackBarErrorSuccefull(context,
          'Ha ocurrido un error, por favor intentelo nuevamente', Colors.red);
    }
  }

  Future<void> logIn(
      String email, String password, bool init, BuildContext context) async {
    var response = await http.post(
        Uri.parse('http://apptllevo.com:8089/api/auth/login'),
        body: ({"email": email, "password": password}));
    if (response.statusCode == 200) {
      LogIn message = LogIn.fromJson(jsonDecode(response.body));
      Map payload = LogIn.fromJson(jsonDecode(response.body)).payload;
      bool success = LogIn.fromJson(jsonDecode(response.body)).success;
      if (message.message == 'you must verify your user') {
        // ignore: use_build_context_synchronously
        Const().snackBarErrorSuccefull(
            context, 'Debes verificar tu usuario', Colors.red);
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Phone(
                    name: '', email: email, password: password)));
      }else if (message.message == 'your account is under review') {
        // ignore: use_build_context_synchronously
        Const().snackBarErrorSuccefull(
            context, 'Tu cuenta está en revision, intenta de nuevo más tarde', Colors.red);
      } else if (message.message ==
          'credential not found. Verify email and password') {
        // ignore: use_build_context_synchronously
        Const().snackBarErrorSuccefull(
            context,
            'Credenciales no encontradas, verifica tu correo y contraseña',
            Colors.red);
      } else if (success == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLogin', true);
        prefs.setString('tokenUser', message.payload['access_token']);
        if (init == true) {
          print('hola?');
          // ignore: use_build_context_synchronously
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Home(show: false)));
        } else {
          // ignore: use_build_context_synchronously
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TermCond(login: true)));
        }
      }
    } else {
      // ignore: use_build_context_synchronously
      Const().snackBarErrorSuccefull(context,
          'Ha ocurrido un error, por favor intentelo nuevamente', Colors.red);
    }
  }

  Future<void> forgotPassword(String email, String password, String numero,
      bool isForgot, BuildContext context) async {
    var response = await http.post(
        Uri.parse('http://apptllevo.com:8089/api/auth/forgot-password'),
        body: ({"email": email}));
    if (response.statusCode == 200) {
      Map payload = ForgotPassword.fromJson(jsonDecode(response.body)).payload;
      if (payload['message'] == 'Error, email no válido') {
        // ignore: use_build_context_synchronously
        Const().snackBarErrorSuccefull(context, 'Correo no valido', Colors.red);
      } else if (payload['message'] == 'Verificación de email exitoso') {
        if (isForgot == true) {
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecuperarPassword(
                        id: payload['user_id'].toString(),
                      )));
        } else {
          findCode(payload['user_id'], context, numero, email, password, true);
        }
      }
    } else {
      // ignore: use_build_context_synchronously
      Const().snackBarErrorSuccefull(context,
          'Ha ocurrido un error, por favor intentelo nuevamente', Colors.red);
    }
  }

  Future<void> resetPassword(
      String id, String password, BuildContext context) async {
    var response = await http.post(
        Uri.parse('http://apptllevo.com:8089/api/auth/reset-password'),
        body: ({"user_id": id, "password": password}));
    if (response.statusCode == 200) {
      String payload =
          ResetPassword.fromJson(jsonDecode(response.body)).payload;
      bool success = ResetPassword.fromJson(jsonDecode(response.body)).success;
      if (success == false) {
        // ignore: use_build_context_synchronously
        Const().snackBarErrorSuccefull(context,
            'Ha ocurrido un error, vuelve a intentarlo más tarde', Colors.red);
      } else if (success == true) {
        // ignore: use_build_context_synchronously
        Const().snackBarErrorSuccefull(
            context, 'Se ha cambiado exitosamente!', Colors.green);
        var nav = Navigator.of(context);
        nav.pop();
        nav.pop();
      }
    } else {
      // ignore: use_build_context_synchronously
      Const().snackBarErrorSuccefull(context,
          'Ha ocurrido un error, por favor intentelo nuevamente', Colors.red);
    }
  }

  Future<Map<dynamic, dynamic>> myData(
      String tokenUser, BuildContext context) async {
    Map map = {};
    var response = await http.get(
        Uri.parse('http://apptllevo.com:8089/api/auth/me'),
        headers: {'Authorization': 'Bearer $tokenUser'});
    if (response.statusCode == 200) {
      Map payload = MyData.fromJson(jsonDecode(response.body)).payload;
      bool success = MyData.fromJson(jsonDecode(response.body)).success;
      if (success == false) {
        print('False algo malo pasó :c');
      } else if (success == true) {
        map = payload;
        return payload;
      }
    } else {
      // ignore: use_build_context_synchronously
      Const().snackBarErrorSuccefull(context,
          'Ha ocurrido un error, por favor intentelo nuevamente', Colors.red);
    }
    return map;
  }

  Future<void> logOut(String tokenUser, BuildContext context) async {
    var response = await http.get(
        Uri.parse('http://apptllevo.com:8089/api/auth/logout'),
        headers: {'Authorization': 'Bearer $tokenUser'});
    if (response.statusCode == 200) {
      bool success = LogOut.fromJson(jsonDecode(response.body)).success;
      if (success == false) {
        print('No deberia estár aqui');
      } else if (success == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLogin', false);
        prefs.setString('tokenUser', '');
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Welcome()));
      }
    } else {
      // ignore: use_build_context_synchronously
      Const().snackBarErrorSuccefull(context,
          'Ha ocurrido un error, por favor intentelo nuevamente', Colors.red);
    }
  }

  Future<void> updateLocationDriver(LatLng coordenada, String tokenUser) async {
    var response = await http.post(
        Uri.parse('http://apptllevo.com:8089/api/driver/update-localitation?latitude=${coordenada.latitude}&longitude=${coordenada.longitude}'),
        headers: {'Authorization': 'Bearer $tokenUser'});
    if (response.statusCode == 200) {
      bool success = UpdateLocationDriver.fromJson(jsonDecode(response.body)).success;
      Map message = UpdateLocationDriver.fromJson(jsonDecode(response.body)).payload;
      //Map payload = UpdateLocationDriver.fromJson(jsonDecode(response.body)).payload;
      print(tokenUser);
      print('Update Location, todo bien -> $success, $message');
    } else {
     print('Un error bro :c');
    }
  }
}
