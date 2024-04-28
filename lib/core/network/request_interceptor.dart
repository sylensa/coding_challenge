import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';



 Map<String, String> requestHeaders = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'x-client' : 'mobile'
};

class HeadersInterceptor extends Interceptor {
  HeadersInterceptor(this._headers);

  final Map<String, String> _headers;

  @override
  Future onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
    if (!options.headers.containsKey('Authorization')) {
      options.headers.addAll(_headers);
    }
    options.headers['Authorization'] = 'Bearer ';
    handler.next(options);
  }



  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }


  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    print("requestOptions.headers:${requestOptions.headers}");
      final options = Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType:ResponseType.json,
      );
      final res =  await Dio().request<dynamic>(requestOptions.path, data: requestOptions.data, queryParameters: requestOptions.queryParameters, options: options);

        return res;
  }


}




