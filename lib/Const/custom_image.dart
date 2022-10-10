import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show BitmapDescriptor;

Future<BitmapDescriptor> getAssetImageMarker(String assets)async{

  return BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(
      devicePixelRatio: 2.5
    ), 
    assets);

}