import 'dart:io';

import 'package:dio/dio.dart';

import 'check_network_status.dart';

class Network {
  final _dio = Dio();

  Network(String baseUrl) {
    _initDio(baseUrl);
  }

  _initDio(String baseUrl) {
    _dio.options
      ..baseUrl = baseUrl
      ..connectTimeout = const Duration(seconds: 3).inMilliseconds
      ..receiveTimeout = const Duration(seconds: 3).inMilliseconds
      ..sendTimeout = const Duration(seconds: 3).inMilliseconds;

    _dio.interceptors.addAll([
      LogInterceptor(
        request: false,
        requestHeader: false,
        requestBody: false,
        responseHeader: false,
        responseBody: false,
        error: true,
      ),
      const ConnectivityInterceptor(),
    ]);
  }

  Future<Map<String, dynamic>> get(String path,
      {String? token, Map<String, dynamic>? params}) async {
    print(
        "---------------------------- Зашли в get ----------------------------------");
    try {
      final response = await _dio.get(path, queryParameters: params);
      return response.data;
    } catch (_) {
      return {};
    }
  }
}

class ConnectivityInterceptor implements Interceptor {
  const ConnectivityInterceptor();

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('Interceptor $err');
    if (err.type == DioErrorType.connectTimeout ||
        err.type == DioErrorType.receiveTimeout ||
        err.type == DioErrorType.sendTimeout ||
        err.error is SocketException) {
      if (CheckNetworkStatus().isConn) {
        CheckNetworkStatus().changeStatus();
      }
    }
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) =>
      handler.next(options);

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Interceptor $response');
    if (response.statusCode == 200 && !CheckNetworkStatus().isConn) {
      CheckNetworkStatus().changeStatus();
    }
    handler.next(response);
  }
}
