import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tllevo_driver/Pages/Home/home.dart';
import 'Const/const.dart';
import 'Pages/Inicio/welcome.dart';

class InitSplash extends StatefulWidget {
  const InitSplash({Key? key}) : super(key: key);

  @override
  State<InitSplash> createState() => _InitSplashState();
}

class _InitSplashState extends State<InitSplash> {

  late bool isLogin;

getBoolValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return bool
  isLogin = prefs.getBool('isLogin') ?? false;
  return isLogin;
}

  @override
  void initState() {
    super.initState();
    getBoolValuesSF();
    Future.delayed(const Duration(milliseconds: 3000),
        () => Navigator.push(context, _crearRuta()));
  }

  Route _crearRuta() {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) => 
           isLogin ? Home(show: false) :
            const Welcome(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation =
              CurvedAnimation(parent: animation, curve: Curves.easeInOut);

          return FadeTransition(
              opacity:
                  Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
              child: child);
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Const().black,
      body: Center(
        child: SvgPicture.asset(
          'Assets/Images/logo.svg',
          width: size.width*0.8,
        ),
      ),
    );
  }
}
