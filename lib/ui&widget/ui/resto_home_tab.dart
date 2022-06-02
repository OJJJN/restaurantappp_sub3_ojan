import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/ui/resto_detail_page.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/ui/resto_home_page.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/ui/resto_setting_page.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/widget/plat_widget.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/ui/resto_favorite_page.dart';
import 'package:restauranttt_sub3_rev3/datareston&api/databasehelper/helper/notification_helper.dart';

class RestoHomeTab extends StatefulWidget {
  static const routeName = '/resto_home_tab';

  const RestoHomeTab({Key? key}) : super(key: key);

  @override
  State<RestoHomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<RestoHomeTab> {
  int _bottomNavIndex = 0;
  static const String _headlineText = 'Home';
  final NotificationHelper _notificationHelper = NotificationHelper();
  final List<Widget> _listWidget = [
    RestoHomePage(),
    RestoFavoritePage(),
    RestoSettingPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home),
      label: _headlineText,
    ),
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.square_favorites_alt : Icons.favorite),
        label: 'Favorite'
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: RestoSettingPage.settingsTitle,

    ),
  ];

  void _onBottomNavTapped(int index){
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context){
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context){
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: _bottomNavBarItems,
        ),
        tabBuilder: (context, index){
          return _listWidget[index];
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  @override
  void initState(){
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(RestoDetailPage.routeName);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    selectNotificationSubject.close();
  }
}
