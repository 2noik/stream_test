// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:stream_pain/services/check_network_status.dart';
import 'package:stream_pain/services/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      home: AppSplashScreen(),
    );
  }
}
