import 'dart:async';
import 'package:dio/dio.dart';
import 'package:stream_pain/services/network.dart';

class CheckNetworkStatus {
  bool isConn = true;

  final _streamController = StreamController<bool>.broadcast();

  Stream<dynamic> get connUpdates => _streamController.stream;

  Timer? timer;

  CheckNetworkStatus._();

  static final CheckNetworkStatus _instance = CheckNetworkStatus._();

  factory CheckNetworkStatus() {
    return _instance;
  }

  void changeStatus() {
    print('changeStatus');
    isConn = !isConn;
    if (!isConn) {
      checkUpdates();
    } else {
      timer?.cancel();
    }
    _streamController.add(isConn);
  }

  void checkUpdates() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      print(
          "timer[${timer.hashCode}].tick = ------------------------ ${timer.tick} ------------------------");
      try {
        await Network("https://backend.specialscomedy.com/api")
            .get("/feed/products/057db18a-8368-4d84-bad8-5270cd634301");
      } catch (e) {}
    });
    print('[${timer.hashCode}] checkUpdates');
  }

  void dispose() {
    _streamController.close();
  }
}
