import 'package:restauranttt_sub3_rev3/datareston&api/databasehelper/database_helper.dart';
import 'package:restauranttt_sub3_rev3/datareston&api/model&respon/resto.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/utils/result_state.dart';
import 'package:flutter/material.dart';

class RestoDatabaseProvider extends ChangeNotifier{
  final DatabaseHelper databaseHelper;

  RestoDatabaseProvider({required this.databaseHelper}){
    getFavorite();
  }

  ResultState? _state;
  ResultState? get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurants> _favorite = [];
  List<Restaurants> get favorite => _favorite;

  void getFavorite() async{
    _favorite = await databaseHelper.getFavorite();
    if(_favorite.isNotEmpty){
      _state = ResultState.hasData;
    }else{
      _state = ResultState.noData;
      _message = 'Belum ada nih :(';
    }
    notifyListeners();
  }

  void addFavorite(Restaurants restaurants) async{
    try{
      await databaseHelper.insertFavorite(restaurants);
      getFavorite();
    }catch (e){
      _state = ResultState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async{
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id)async{
    try{
      await databaseHelper.removeFavorite(id);
      getFavorite();
    }catch (e){
      _state = ResultState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }
}