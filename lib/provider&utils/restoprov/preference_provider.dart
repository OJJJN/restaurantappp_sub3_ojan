import 'package:restauranttt_sub3_rev3/datareston&api/databasehelper/helper/preference_helper.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/utils/theme.dart';
import 'package:flutter/material.dart';

class PreferenceProvider extends ChangeNotifier{
  PreferenceHelper preferenceHelper;

  PreferenceProvider({required this.preferenceHelper}){
    _getTheme();
    _getDailyRestaurant();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isDailyRestaurantActive = false;
  bool get isDailyRestaurant => _isDailyRestaurantActive;

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;


  void _getTheme() async{
    _isDarkTheme = await preferenceHelper.isDarkTheme;
    notifyListeners();
  }

  void _getDailyRestaurant() async{
    _isDailyRestaurantActive = await preferenceHelper.isDailyRestaurantActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value){
    preferenceHelper.setDarkTheme(value);
    _getTheme();
  }
  void ebaleDailyRestaurant(bool value){
    preferenceHelper.setDailyRestaurant(value);
    _getDailyRestaurant();
  }
}