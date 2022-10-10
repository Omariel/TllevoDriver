import 'package:dio/dio.dart';


class PlacesInterceptor extends Interceptor {
  
  final accessToken = 'pk.eyJ1Ijoib21hcmllbCIsImEiOiJjbDhpcWZtZmMwNXo4M3dwY2M5OXhvbHowIn0.f9ml4RCsb84G8gRExj1TuQ';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'access_token': accessToken,
      'language': 'es',
      'limit' : 7
    });


    super.onRequest(options, handler);
  }

}