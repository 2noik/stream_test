import 'package:dio/dio.dart' as dio;

import 'check_network_status.dart';

class Network {
  final _dio = dio.Dio();

  Network(String baseUrl) {
    _initDio(baseUrl);
  }

  _initDio(String baseUrl) {
    _dio.options
      ..baseUrl = baseUrl
      ..connectTimeout = const Duration(seconds: 3).inMilliseconds
      ..receiveTimeout = const Duration(seconds: 3).inMilliseconds
      ..sendTimeout = const Duration(seconds: 3).inMilliseconds;

    _dio.interceptors.add(
      dio.LogInterceptor(
        request: false,
        requestHeader: false,
        requestBody: false,
        responseHeader: false,
        responseBody: false,
        error: true,
      ),
    );
  }

  Future<Map<String, dynamic>> get(String path,
      {String? token, Map<String, dynamic>? params}) async {
    print(
        "---------------------------- Зашли в get ----------------------------------");
    try {
      final response = await _dio.get(path, queryParameters: params);
      if (response.statusCode == 200) {
        if (CheckNetworkStatus().isConn == false) {
          CheckNetworkStatus().changeStatus();
        }
        return response.data;
      } else {
        return {};
      }
    } catch (e) {
      if (CheckNetworkStatus().isConn == true) {
        CheckNetworkStatus().changeStatus();
      }
      return {};
    }
  }
}
