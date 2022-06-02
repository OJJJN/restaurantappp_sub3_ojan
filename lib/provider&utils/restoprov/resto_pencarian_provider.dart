import 'dart:async';
import 'package:restauranttt_sub3_rev3/datareston&api/api/api.dart';
import 'package:restauranttt_sub3_rev3/datareston&api/model&respon/respon/resto_list_pencarian.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/utils/result_state.dart';
import 'package:flutter/cupertino.dart';

class RestoPencarianProvider extends ChangeNotifier{
  final Api api;

  RestoPencarianProvider({required this.api}){
    fetchSearchRestaurant(query);
  }
  String _query = '';
  String get query => _query;

  String _message = '';
  String get message => _message;


  RestoListPencarian? _restoPencarianProvider;
  RestoListPencarian? get result => _restoPencarianProvider;

  ResultState? _state;
  ResultState? get state => _state;


  Future<dynamic> fetchSearchRestaurant(String query) async{
    try{
      _state = ResultState.loading;
      _query = query;

      final restaurantSearch = await api.getSearch(query);
      if(restaurantSearch.restaurants.isEmpty){
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Yah, Resto Yang Kamu Cari Ga ada nih :(';
      }else{
        _state = ResultState.hasData;
        notifyListeners();
        return _restoPencarianProvider = restaurantSearch;
      }
    } catch (e){
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}
