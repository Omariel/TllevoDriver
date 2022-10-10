
import 'package:flutter/material.dart';

class OrderPendient {
  OrderPendient({Key? key, required this.success, required this.payload});

  bool success;
  List payload;

  factory OrderPendient.fromJson(Map<String, dynamic> json) {
    return OrderPendient(success: json['success'], payload: json['payload']);
  }
}

class BuscandoPersona {
  BuscandoPersona({Key? key, required this.success, required this.payload});

  bool success;
  bool payload;

  factory BuscandoPersona.fromJson(Map<String, dynamic> json) {
    return BuscandoPersona(success: json['success'], payload: json['payload']);
  }
}

class AvailableState {
  AvailableState({Key? key, required this.success, required this.payload});

  bool success;
  Map payload;

  factory AvailableState.fromJson(Map<String, dynamic> json) {
    return AvailableState(success: json['success'], payload: json['payload']);
  }
}