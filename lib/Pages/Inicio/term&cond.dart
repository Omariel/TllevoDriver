import 'package:flutter/material.dart';
import 'package:tllevo_driver/Pages/Inicio/finish.dart';
import 'package:tllevo_driver/Widget/button.dart';

import '../../Const/const.dart';

class TermCond extends StatefulWidget {
  bool login;
  TermCond({Key? key, required this.login}) : super(key: key);

  @override
  State<TermCond> createState() => _TermCondState();
}

class _TermCondState extends State<TermCond> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(top: 0,child: Image.asset('Assets/Images/Group.png', height: size.height*0.43,)),
        //   Positioned(
        //   top: size.height * 0.05,
        //   left: size.width * 0.02,
        //   child: IconButton(
        //       onPressed: () => Navigator.of(context).pop(),
        //       icon: const Icon(
        //         Icons.cancel_outlined,
        //         color: Colors.black,size: 30,
        //       )),
        // ),
          Positioned(
            top: size.height*0.45,
            child: Text(
              'Terminos y condiciones',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: size.height * 0.035,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  height: 1),
            ),
          ),
          Positioned(
            top: size.height*0.52,
            left: size.width*0.15,
            right: size.width*0.15,
            child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. \n\nIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: size.height * 0.017,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  height: 1.1),
            ),
          ),
          Positioned(
            bottom: size.height * 0.08,
            child: SizedBox(
                height: size.height * 0.06,
                width: size.width * 0.8,
                child: Button(
                    callback: () => widget.login?
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> Finish(name: 'Ricardo',))):
                     Navigator.of(context).pop(),                 
                    height: 0.025,
                    text: 'Acepto',
                    size: size, color: Const().black, colorTxt: Colors.white,)))
        ],
      ),
    );
  }
}