import 'package:flutter/cupertino.dart';
import 'package:stream_pain/services/network.dart';

class ReleasesPage extends StatefulWidget {
  const ReleasesPage({Key? key}) : super(key: key);

  @override
  State<ReleasesPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ReleasesPage> {
  bool? _isUpdate;

  void _update() async {
    final res = await Network("https://backend.specialscomedy.com/api")
        .get("/feed/products/057db18a-8368-4d84-bad8-5270cd634301");
    if (res.isNotEmpty) {
      setState(() {
        _isUpdate = true;
      });
    } else {
      setState(() {
        _isUpdate = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        middle: Text("Релизы"),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'После подключения/отключения интернета нажмите на кнопку',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15.0,
              ),
              Visibility(
                  visible: _isUpdate != null,
                  child: _isUpdate != null && _isUpdate!
                      ? const Text(
                          'Обновлено',
                        )
                      : const Text(
                          'Не обновлено',
                        )),
              const SizedBox(
                height: 15.0,
              ),
              CupertinoButton(
                color: CupertinoColors.activeBlue,
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                onPressed: _update,
                child: const Text(
                  "Обновить",
                  style: TextStyle(color: CupertinoColors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
