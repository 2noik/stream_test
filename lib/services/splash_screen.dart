import 'package:flutter/cupertino.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:stream_pain/pages/tabs_page.dart';

import 'network.dart';

class AppSplashScreen extends StatefulWidget {
  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  Future<Widget> loadFromFuture() async {
    await Network("https://backend.specialscomedy.com/api")
        .get("/feed/products/057db18a-8368-4d84-bad8-5270cd634301");

    return const TabsPage();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SplashScreen(
        navigateAfterFuture: loadFromFuture(),
        backgroundColor: CupertinoColors.black,
        title: const Text(
          "StreamOfPain",
          style: TextStyle(
            color: CupertinoColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 50.0,
            letterSpacing: -1.0,
          ),
        ),
        styleTextUnderTheLoader: const TextStyle(),
        loadingText: const Text("Загрузка"),
        loadingTextPadding: EdgeInsets.zero,
        useLoader: true,
        loaderColor: CupertinoColors.white,
      ),
    );
  }
}
