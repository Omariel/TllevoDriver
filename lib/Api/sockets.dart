import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class Sockets {
  final socket = IO.io('http://apptllevo.com:8092', 
      OptionBuilder()
        .setTransports(['websocket', 'polling', 'flashsocket'])
        .enableForceNew().build()
      );
  bool isConnected= false;
  Sockets(){
    socket.onConnect((data) {
      isConnected = true;
      print('conectado ');
      print(socket.id);
    });
  }

  addUser() {
    if(isConnected) {
      socket.emit('add-user', {'email': 'prueba3@prueba3.com', 'name': 'prueba gg'});
    }
  }
  StreamController ownMess = StreamController.broadcast();
  ownMessage() {
    if(isConnected) {
      socket.on('own-message', (data) {
      [
        {'owner': 'You', 'content': data['content']}
      ];
    print(data);
    });
    }
  }
    addMessage() {
    if(isConnected) {
      socket.on('add-message', (data) {
        [{
          'email': 'prueba01@prueba1.com',
          'name': 'Omar',
          'content': data['content']
        }];
    });
    }
  }

 sendMessagee(String email, String name, String message, String sender) => {
  socket.emit("private-message", {
    'email': email,
    'name': name,
    'content': message,
    sender: sender,
  })
};

  sendMessage(String email, String name, String message, String sender) {
    if(isConnected) {
      print('efectivamente deberia hacerlo');
      socket.emit('private-message',
        {'email': email, 'name': name, 'content': message, 'sender': sender});
    }
  }
}
