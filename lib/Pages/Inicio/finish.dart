import 'package:flutter/material.dart';

import '../../Const/const.dart';
import '../../Widget/button.dart';
import '../Home/home.dart';

class Finish extends StatelessWidget {
  Finish({Key? key, required this.name}) : super(key: key);
  String name;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(alignment: Alignment.topCenter, children: [
        Positioned(
          top: size.height * 0.15,
          left: size.width * 0.2,
          right: size.width * 0.2,
          child: Text(
            'Bienvenido,\n$name',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: size.height * 0.035,
                color: Colors.black,
                fontFamily: 'Poppins',
                height: 1),
          ),
        ),
        
        Positioned(
            top: size.height * 0.27,
            left: size.width * 0.15,
            right: size.width * 0.2,
            child: Image.asset('Assets/Images/finish.png')),
         Positioned(
            bottom: size.height * 0.08,
            child: SizedBox(
                height: size.height * 0.06,
                width: size.width * 0.8,
                child: Button(
                    callback: () {

                     Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(show: false,)));
                    },
                    
                    height: 0.025,
                    text: 'Comenzar viajes',
                    size: size, color: Const().black, colorTxt: Colors.white,)))
      ]),
    );
  }
}
