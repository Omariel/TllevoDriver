import 'dart:math';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

// ignore: must_be_immutable
class SoporteChat extends StatefulWidget {
  SoporteChat({Key? key, required this.myEmail}) : super(key: key);
  String myEmail;

  @override
  State<SoporteChat> createState() => _SoporteChatState();
}

class _SoporteChatState extends State<SoporteChat> {
  TextEditingController controller = TextEditingController();
  bool isConnected = false;
  IO.Socket? socket;
  List myMessages = [];
  List theirMessages = [];
  List totalMessages = [];
  Map data = {};

  initSocket() {
    socket = IO.io(
        'http://apptllevo.com:8092',
        OptionBuilder()
            .setTransports(['websocket', 'polling', 'flashsocket'])
            .enableForceNew()
            .build());

    socket!.onConnect((data) {
      setState(() {
        
      isConnected = true;
      });
      socket!.emit(
          'add-user', {'email': widget.myEmail, 'name': 'prueba gg'});

      socket!.on('add-message', (data) {
        setState(() {
          theirMessages.insert(0, data);
          totalMessages.insert(0, data);
        });
      });

      socket!.on('own_message', (data) {
        setState(() {
          myMessages.insert(0, data);
          totalMessages.insert(0, data);
          this.data = data;
        });
      });
    });
  }

  sendMessagee(String email, String name, String message, String sender) =>
      socket!.emit("private-message", {
        'email': email,
        'name': name,
        'content': message,
        'sender': sender,
      });

  @override
  void initState() {
    initSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          isConnected == false ?
      const Center(child: CircularProgressIndicator(),) :
          ListView.builder(
              reverse: true,
              padding: EdgeInsets.only(bottom: size.height * 0.2, top: size.height *0.2),
              itemCount: totalMessages.length,
              itemBuilder: ((context, index) {
                if (totalMessages[index]['email'] == widget.myEmail) {
                  return Padding(
                    padding: EdgeInsets.only(
                        right: size.width * 0.1,
                        left: size.width * 0.4,
                        top: size.height * 0.015),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  bottomLeft: Radius.circular(18),
                                  topRight: Radius.circular(18),
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    totalMessages[index]['content'],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding:const  EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    height: 1,
                                    width: size.width*1,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5, top: 2),
                                  child: Text(
                                   DateFormat('hh:mm a').format(DateTime.now()),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        CustomPaint(painter: CustomShape(Colors.black))
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.1,
                        right: size.width * 0.4,
                        top: size.height * 0.015),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(pi),
                            child: CustomPaint(
                                painter: CustomShape(const Color(0xffF2F2F2)))),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: const BoxDecoration(
                                color: Color(0xffF2F2F2),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  bottomRight: Radius.circular(18),
                                  topRight: Radius.circular(18),
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    totalMessages[index]['content'],
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding:const  EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    height: 1,
                                    width: size.width*1,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5, top: 2),
                                  child: Text(
                                   DateFormat('hh:mm a').format(DateTime.now()),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 12),
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
              })
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
                    left: size.width * 0.36,
                    child: Text(
                      'Soporte',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: size.height * 0.033,
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
                      controller: controller,
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
                    onPressed: () {
                      sendMessagee(widget.myEmail, 'User',
                          controller.text, 'admin@admin.com');
                      controller.clear();
                    },
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

class CustomShape extends CustomPainter {
  final Color bgColor;

  CustomShape(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;

    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, -20);
    path.quadraticBezierTo(3, -5, 15, 0);
    //path.lineTo(10, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
