import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tllevo_driver/Pages/Inicio/Login/login.dart';
import 'package:tllevo_driver/Pages/Inicio/registro.dart';
import 'package:tllevo_driver/Widget/button.dart';

import '../../Const/const.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: size.height*0.1,
              child: SvgPicture.asset('Assets/Images/logoBlack.svg', width: size.width*0.7,)),
            Positioned(
              top: size.height*0.25,
              left: size.width*0.075,
              child: Image.asset('Assets/Images/WelcomeImage.png',)),
            Positioned(
              top: size.height*0.67,
              left: size.width*0.2,
              right: size.width*0.2,
              child: Text(
                'Sé parte de nuestro equipo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1,
                  fontSize: size.height*0.035,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'Poppins'
                ),
              ),
            ),
            Positioned(
              bottom: size.height*0.16,
              child: SizedBox(
              height: size.height*0.06,
              width: size.width*0.8,
              child: Button(callback: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
              }, height: 0.026, text: 'Iniciar sesión', size: size, color: Const().yellow, colorTxt: Colors.black))),
            Positioned(
              bottom: size.height*0.08,
              child: SizedBox(
                height: size.height*0.06,
                width: size.width*0.8,
                child: ElevatedButton(
                    style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                      Const().black,
                    )),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>  Registro(name: '',)));
                    },
                    child: Text(
                                'Regístrate',
                                style: TextStyle(
                    fontSize: size.height * 0.025,
                    color: Colors.white,
                    fontFamily: 'Poppins'),
                      ),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}