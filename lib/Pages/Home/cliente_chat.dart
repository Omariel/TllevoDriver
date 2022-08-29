import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ClienteChat extends StatelessWidget {
  const ClienteChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(top: size.height*0.5),
            children: [
              Stack(
                children: [
                  SvgPicture.asset('Assets/Images/ChatRecive.svg',),
                  Positioned(
                    top: size.height*0.03,
                    left: size.width*0.1,
                    child: Text('Buenas tardes', style: TextStyle(
                      fontWeight: FontWeight.w500,
                        fontSize: size.height * 0.015,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                    ),)),
                    Positioned(
                      top: size.height*0.07,
                      left: size.width*0.08,
                      child: Container(
                        height: 2, width: size.width*0.7,
                        color: Colors.black,
                      )),
                  Positioned(
                    top: size.height*0.076,
                    right: size.width*0.25,
                    child: Text('3:05 P.M.', style: TextStyle(
                      fontWeight: FontWeight.w500,
                        fontSize: size.height * 0.015,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                    ),)),
                ],
              ),
              SizedBox(height: size.height*0.02,),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  SvgPicture.asset('Assets/Images/ChatSend.svg'),
                  Positioned(
                    top: size.height*0.02,
                    left: size.width*0.4,
                    child: Text('Buenas tardes Carlos, voy\nen camino', style: TextStyle(
                      fontWeight: FontWeight.w500,
                        fontSize: size.height * 0.015,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                    ),)),
                    Positioned(
                      top: size.height*0.07,
                      right: size.width*0.08,
                      child: Container(
                        height: 2, width: size.width*0.55,
                        color: Colors.white,
                      )),
                  Positioned(
                    top: size.height*0.076,
                    left: size.width*0.4,
                    child: Text('3:06 P.M.', style: TextStyle(
                      fontWeight: FontWeight.w500,
                        fontSize: size.height * 0.015,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                    ),)),
                ],
              )
            ],
          ),
          Positioned(
            top: 0,
            child: Container(
              width: size.width * 1,
              height: size.height * 0.17,
              color: const Color(0xffF4F2F2),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: size.height * 0.04,
                    left: size.width * 0.02,
                    child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        )),
                  ),
                  Positioned(
                      top: size.height * 0.1,
                      left: size.width * 0.1,
                      child: SvgPicture.asset(
                        'Assets/Images/simpleFace.svg',
                        height: size.height * 0.05,
                      )),
                  Positioned(
                    top: size.height * 0.11,
                    left: size.width * 0.3,
                    child: Text(
                      'Carlos Escamilla',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: size.height * 0.021,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width * 1,
              height: size.height * 0.17,
              color: const Color(0xffF4F2F2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.7,
                    height: size.height * 0.08,
                    child: TextField(
                      enableSuggestions: false,
                      autocorrect: false,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.5))),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.black,
                        ),
                        shape: MaterialStateProperty.all(const CircleBorder())),
                    child: Padding(
                      padding: EdgeInsets.all(size.height * 0.01),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: size.height * 0.05,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
