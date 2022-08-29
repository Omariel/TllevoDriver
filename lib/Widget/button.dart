import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  VoidCallback callback;
  double height;
  String text;
  Size size;
  Color color;
  Color colorTxt;
  Button(
      {Key? key,
      required this.callback,
      required this.height,
      required this.text,
      required this.size,
      required this.color,
      required this.colorTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
        color,
      )),
      onPressed: () {
        callback();
      },
      child: Center(
          child: Text(
        text,
        style: TextStyle(
            fontSize: size.height * height,
            color: colorTxt,
            fontFamily: 'Poppins'),
      )),
    );
  }
}
