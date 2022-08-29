import 'package:flutter/material.dart';

class Const {
  Color black = const Color.fromRGBO(18, 24, 31, 1);
  Color yellow = const Color(0xffF9BE00);
  void snackBarErrorSuccefull(BuildContext context, String txt, Color colorBg) {
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        backgroundColor: colorBg,
        content: Text(
          txt,
          style: const TextStyle(
              fontSize: 18, color: Colors.white, fontFamily: 'Poppins'),
        )));
  }
  void snackBarOthers(BuildContext context, String txt) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.grey.shade300,
            content: Text(
          txt,
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        )));
  }
}
