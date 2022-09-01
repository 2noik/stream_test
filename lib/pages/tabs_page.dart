import 'package:flutter/cupertino.dart';

import 'package:stream_pain/pages/profile_page.dart';
import 'package:stream_pain/pages/releases_page.dart';
import 'package:stream_pain/pages/search_page.dart';
import 'package:stream_pain/pages/user_product_page.dart';
import 'package:stream_pain/services/check_network_status.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final _tabController = CupertinoTabController();

  List<Widget>? tabs;
  bool? status;

  @override
  void initState() {
    tabs = [
      const ReleasesPage(),
      const SearchPage(),
      const UserProductsPage(),
      const ProfilePage(),
    ];

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
        initialData: CheckNetworkStatus().isConn,
        stream: CheckNetworkStatus().connUpdates,
        builder: (context, snapshot) {
          print(
              " ------------------------ isConn snapshot: ${snapshot.data!}, ${snapshot.connectionState}, ${snapshot.error} -----------------------------------");
          return CupertinoTabScaffold(
            controller: _tabController,
            tabBar: CupertinoTabBar(
              onTap: (index) {
                if (snapshot.data! == false) {
                  _tabController.index = 2;
                } else {
                  _tabController.index = index;
                }
              },
              currentIndex: snapshot.data! ? 0 : _tabController.index = 2,
              backgroundColor: CupertinoColors.black.withOpacity(0.0),
              activeColor: CupertinoColors.white,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.plus_app, size: 23.0),
                  label: "Релизы",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.search, size: 23.0),
                  label: "Поиск",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.play_circle_fill, size: 23.0),
                  label: "Мой контент",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.profile_circled, size: 23.0),
                  label: "Профиль",
                ),
              ],
            ),
            tabBuilder: (context, index) {
              return tabs![index];
            },
          );
        });
  }
}
