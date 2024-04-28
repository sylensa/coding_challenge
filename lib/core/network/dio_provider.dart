import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:coding_challenge/core/network/chunk.dart';
import 'package:coding_challenge/core/network/request_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


final Dio dio = Dio(BaseOptions(
  connectTimeout: const Duration(minutes: 2),
  receiveTimeout: const Duration(minutes: 2),
))
  ..interceptors.add(InterceptorsWrapper(onRequest: (_, __) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      // return null;
      return dioClient;
    };
    __.next(_);
  }))
  ..interceptors.add(HeadersInterceptor(requestHeaders))
  ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 250))
  ..interceptors.add(chuck.getDioInterceptor())
  ..interceptors.add(InterceptorsWrapper(onRequest: (_, __) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      // return null;
      return dioClient;
    };
    __.next(_);
  }));
