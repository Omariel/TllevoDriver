import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tllevo_driver/Const/const.dart';
import 'package:tllevo_driver/Models/models_home.dart';

class ApiHome {

  Future<List<dynamic>> orderPendient(String tokenUser,
      BuildContext context) async {
    var response = await http.get(
        Uri.parse('http://apptllevo.com:8089/api/driver/get-order/pendint'),
        headers: {'Authorization': 'Bearer $tokenUser'});
    if (response.statusCode == 200) {
      bool success = OrderPendient.fromJson(jsonDecode(response.body)).success;
      List payload = OrderPendient.fromJson(jsonDecode(response.body)).payload;
      if(success == true){
        return payload;
      }
    } else {
      // ignore: use_build_context_synchronously
      Const().snackBarErrorSuccefull(context,
          'Ha ocurrido un error, por favor intentelo nuevamente', Colors.red);
    }
      return [];
  }
  Future<List<dynamic>> orderActive(String tokenUser,
      BuildContext context) async {
    var response = await http.get(
        Uri.parse('http://apptllevo.com:8089/api/driver/get-order/active'),
        headers: {'Authorization': 'Bearer $tokenUser'});
    if (response.statusCode == 200) {
      bool success = OrderPendient.fromJson(jsonDecode(response.body)).success;
      List payload = OrderPendient.fromJson(jsonDecode(response.body)).payload;
      if(success == true){
        return payload;
      }
    } else {
      // ignore: use_build_context_synchronously
      Const().snackBarErrorSuccefull(context,
          'Ha ocurrido un error, por favor intentelo nuevamente', Colors.red);
    }
      return [];
  }

  Future<bool> buscandoPersona(String tokenUser, int id,
      BuildContext context) async {
    var response = await http.put(
        Uri.parse('http://apptllevo.com:8089/api/update-order-status/picked-up/$id'),
        headers: {'Authorization': 'Bearer $tokenUser'});
    if (response.statusCode == 200) {
      bool success = BuscandoPersona.fromJson(jsonDecode(response.body)).success;
      bool payload = BuscandoPersona.fromJson(jsonDecode(response.body)).payload;
      if(success == true){
        print('too bien');
        return true;
      }else{
        return false;
      }
    } else {
      // ignore: use_build_context_synchronously
      Const().snackBarErrorSuccefull(context,
          'Ha ocurrido un error, por favor intentelo nuevamente', Colors.red);
    }
    return false;
  }
  Future<bool> llevandoPersona(String tokenUser, int id,
      BuildContext context) async {
    var response = await http.put(
        Uri.parse('http://apptllevo.com:8089/api/update-order-status/on-the-way/$id'),
        headers: {'Authorization': 'Bearer $tokenUser'});
    if (response.statusCode == 200) {
      bool success = BuscandoPersona.fromJson(jsonDecode(response.body)).success;
      bool payload = BuscandoPersona.fromJson(jsonDecode(response.body)).payload;
      if(success == true){
        print('too bien');
        return true;
      }else{
        return false;
      }
    } else {
      // ignore: use_build_context_synchronously
      Const().snackBarErrorSuccefull(context,
          'Ha ocurrido un error, por favor intentelo nuevamente', Colors.red);
    }
    return false;
  }

  Future<bool> terminarViaje(String tokenUser, int id,
      BuildContext context) async {
    var response = await http.put(
        Uri.parse('http://apptllevo.com:8089/api/update-order-status/completed/$id'),
        headers: {'Authorization': 'Bearer $tokenUser'});
    if (response.statusCode == 200) {
      bool success = BuscandoPersona.fromJson(jsonDecode(response.body)).success;
      bool payload = BuscandoPersona.fromJson(jsonDecode(response.body)).payload;
      if(success == true){
        print('too bien');
        return true;
      }else{
        return false;
      }
    } else {
      // ignore: use_build_context_synchronously
      Const().snackBarErrorSuccefull(context,
          'Ha ocurrido un error, por favor intentelo nuevamente', Colors.red);
    }
    return false;
  }
  Future<bool> availableState(String tokenUser,
      BuildContext context) async {
    var response = await http.put(
        Uri.parse('http://apptllevo.com:8089/api/driver/state-driver/available'),
        headers: {'Authorization': 'Bearer $tokenUser'});
    if (response.statusCode == 200) {
      bool success = AvailableState.fromJson(jsonDecode(response.body)).success;
      Map payload = AvailableState.fromJson(jsonDecode(response.body)).payload;
      if(success == true){
        print('too bien');
        return true;
      }else{
        print('too mal');
        return false;
      }
    } else {
      // ignore: use_build_context_synchronously
      Const().snackBarErrorSuccefull(context,
          'Ha ocurrido un error, por favor intentelo nuevamente', Colors.red);
          return false;
    }
  }


  Future<bool> unavailableState(String tokenUser,
      BuildContext context) async {
    var response = await http.put(
        Uri.parse('http://apptllevo.com:8089/api/driver/state-driver/unavailable'),
        headers: {'Authorization': 'Bearer $tokenUser'});
    if (response.statusCode == 200) {
      bool success = AvailableState.fromJson(jsonDecode(response.body)).success;
      Map payload = AvailableState.fromJson(jsonDecode(response.body)).payload;
      if(success == true){
        print('too bien');
        return true;
      }else{
        print('too mal');
        return false;
      }
    } else {
      // ignore: use_build_context_synchronously
      Const().snackBarErrorSuccefull(context,
          'Ha ocurrido un error, por favor intentelo nuevamente', Colors.red);
          return false;
    }
  }
}