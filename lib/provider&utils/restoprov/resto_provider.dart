import 'dart:async';
import 'package:restauranttt_sub3_rev3/datareston&api/api/api.dart';
import 'package:restauranttt_sub3_rev3/datareston&api/model&respon/respon/resto_list_respon.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/utils/result_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class RestoProvider extends ChangeNotifier{
  final Api api;
  RestoProvider({required this.api}){
    fetchAllRestaurant();
  }

  String _message = '';
  String get message => _message;

  late ResultState _state;
  ResultState get state => _state;

  late RestoListRespon _restaurants;
  RestoListRespon get restaurants => _restaurants;




  Future<dynamic> fetchAllRestaurant() async{
    try{
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await api.getTopHeadLines(Client());
      if(restaurant.restaurants.isEmpty){
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Not Found Data';
      }else{
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurants = restaurant;
      }
    }catch (e){
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}