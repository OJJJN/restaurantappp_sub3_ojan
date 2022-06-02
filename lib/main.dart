import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:restauranttt_sub3_rev3/navigation&style/navigation.dart';
import 'package:restauranttt_sub3_rev3/datareston&api/api/api.dart';
import 'package:restauranttt_sub3_rev3/datareston&api/databasehelper/database_helper.dart';
import 'package:restauranttt_sub3_rev3/datareston&api/model&respon/resto.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/restoprov/resto_database_provider.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/restoprov/preference_provider.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/restoprov/resto_detail_provider.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/restoprov/resto_provider.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/restoprov/scheduling_provider.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/restoprov/resto_pencarian_provider.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/ui/resto_detail_page.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/ui/resto_favorite_page.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/ui/resto_home_tab.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/ui/resto_pencarian_page.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/ui/resto_setting_page.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/ui/splash_screen.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/utils/background_service.dart';
import 'package:restauranttt_sub3_rev3/datareston&api/databasehelper/helper/preference_helper.dart';
import 'package:restauranttt_sub3_rev3/datareston&api/databasehelper/helper/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializedIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Api _api = Api();

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider<RestoProvider>(
          create: (_) => RestoProvider(api: _api)),
      ChangeNotifierProvider<RestoPencarianProvider>(
        create: (_) => RestoPencarianProvider(api: _api),
      ),
      ChangeNotifierProvider<RestoDetailProvider>(
          create: (_) =>
              RestoDetailProvider(api: _api)),
      ChangeNotifierProvider<RestoDatabaseProvider>(
        create: (_) => RestoDatabaseProvider(databaseHelper: DatabaseHelper()),
      ),
      ChangeNotifierProvider(
          create: (_) => PreferenceProvider(
              preferenceHelper: PreferenceHelper(
                  sharedPreferences: SharedPreferences.getInstance()))),
      ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider()),
    ],
    child: Consumer<PreferenceProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'RestoSub3',
            theme: provider.themeData,
            builder: (context, child) {
              return CupertinoTheme(
                  data: CupertinoThemeData(
                    brightness: provider.isDarkTheme
                        ? Brightness.dark
                        : Brightness.light,
                  ),
                  child: Material(
                    child: child,
                  ));
            },
            navigatorKey: navigatorKey,
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => const SplashScreen(),
              RestoHomeTab.routeName: (context) => const RestoHomeTab(),
              RestoFavoritePage.routeName: (context) => const RestoFavoritePage(),
              RestoPencarianPage.routeName: (context) =>
              const RestoPencarianPage(),
              RestoDetailPage.routeName: (context) => RestoDetailPage(
                restaurant: ModalRoute.of(context)?.settings.arguments as Restaurants,
              ),
              RestoSettingPage.routeName: (context) => const RestoSettingPage(),
            });
      },
    ),
  );
}
