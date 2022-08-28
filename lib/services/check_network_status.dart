import 'dart:async';
import 'package:dio/dio.dart';

class CheckNetworkStatus {
  bool isConn = true;

  // static добавила
  static StreamController _streamController = StreamController<bool>();

  Stream<dynamic> get connUpdates => _streamController.stream;
  // _streamController.stream.asBroadcastStream();

  CheckNetworkStatus._privateConstructor();

  static final CheckNetworkStatus _instance =
      CheckNetworkStatus._privateConstructor();

  factory CheckNetworkStatus() {
    return _instance;
  }

  void changeStatus() {
    isConn = !isConn;
    _streamController.add(isConn);
  }

  void checkUpdates() {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      print(
          "timer.tick = ------------------------ ${timer.tick} ------------------------");
      try {
        dynamic res = await Dio().get(
            "https://backend.specialscomedy.com/api/feed/products/057db18a-8368-4d84-bad8-5270cd634301");

        if (res != null && res.data.isNotEmpty) {
          changeStatus();
          timer.cancel();
        }
      } catch (e) {}
    });
  }

  void dispose() {
    _streamController.close();
  }
}
