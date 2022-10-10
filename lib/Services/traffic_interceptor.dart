

import 'package:dio/dio.dart';

class TrafficInterceptor extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': 'pk.eyJ1Ijoib21hcmllbCIsImEiOiJjbDhpcWZtZmMwNXo4M3dwY2M5OXhvbHowIn0.f9ml4RCsb84G8gRExj1TuQ',
    });
    super.onRequest(options, handler);
  }
  
}