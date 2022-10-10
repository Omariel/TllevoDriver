import 'package:flutter/material.dart';

class SignUpModel {
  SignUpModel(
      {Key? key,
      required this.message,
      required this.success,
      required this.email,
      required this.id,
      required this.name,
      required this.phone});

  String message, name, email, phone;
  int id;
  bool success;

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return json['success'] == false
        ? SignUpModel(
            message: json['message'],
            success: json['success'],
            email: 'null',
            name: 'null',
            phone: 'null',
            id: -1)
        : SignUpModel(
            message: 'null',
            success: json['success'],
            email: json['payload']['email'],
            name: json['payload']['name'],
            phone: json['payload']['phone'],
            id: json['payload']['id']);
  }
}

class FindCode {
  FindCode({Key? key, required this.code});

  String code;

  factory FindCode.fromJson(Map<String, dynamic> json) {
    return FindCode(code: json['payload']['code']);
  }
}

class VerifyCode {
  VerifyCode({Key? key, required this.message, required this.success});

  String message;
  bool success;

  factory VerifyCode.fromJson(Map<String, dynamic> json) {
    return VerifyCode(
        message: json['success'] == false ? json['message'] : json['payload'],
        success: json['success']);
  }
}

class LogIn {
  LogIn(
      {Key? key,
      required this.message,
      required this.success,
      required this.payload});

  String message;
  bool success;

  Map payload;

  factory LogIn.fromJson(Map<String, dynamic> json) {
    return json['success'] == false
        ? LogIn(message: json['message'], success: json['success'], payload: {})
        : LogIn(
            message: '', success: json['success'], payload: json['payload']);
  }
}

class ForgotPassword {
  ForgotPassword({Key? key, required this.success, required this.payload});

  bool success;

  Map payload;

  factory ForgotPassword.fromJson(Map<String, dynamic> json) {
    return ForgotPassword(success: json['success'], payload: json['payload']);
  }
}

class ResetPassword {
  ResetPassword({Key? key, required this.success, required this.payload});

  bool success;

  String payload;

  factory ResetPassword.fromJson(Map<String, dynamic> json) {
    return ResetPassword(success: json['success'], payload: json['payload']);
  }
}

class MyData {
  MyData(
      {Key? key,
      required this.success,
      required this.payload,
      required this.message});

  bool success;
  String message;
  Map payload;

  factory MyData.fromJson(Map<String, dynamic> json) {
    return json['success'] == true
        ? MyData(
            success: json['success'], payload: json['payload'], message: '')
        : MyData(
            success: json['success'], payload: {}, message: json['message']);
  }
}

class LogOut {
  LogOut({Key? key, required this.success, required this.message});

  bool success;
  String message;

  factory LogOut.fromJson(Map<String, dynamic> json) {
    return LogOut(success: json['success'], message: json['message']);
  }
}

class UpdateLocationDriver {
  UpdateLocationDriver({Key? key, required this.success, required this.payload});

  bool success;
  Map payload;

  factory UpdateLocationDriver.fromJson(Map<String, dynamic> json) {
    return UpdateLocationDriver(success: json['success'], payload: json['payload']);
  }
}
