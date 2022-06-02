import 'dart:async';
import 'package:restauranttt_sub3_rev3/datareston&api/api/api.dart';
import 'package:restauranttt_sub3_rev3/datareston&api/model&respon/respon/resto_details_response.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/utils/result_state.dart';
import 'package:flutter/material.dart';

class RestoDetailProvider extends ChangeNotifier{
  final Api api;

  RestoDetailProvider({required this.api,});

  late RestaurantDetailsResponse _restaurantDetailsResponse;
  RestaurantDetailsResponse get result => _restaurantDetailsResponse;

  String _message = '';
  String get message => _message;

  ResultState? _state;
  ResultState? get state => _state;


  Future<dynamic> getDetails(String id) async {
    try{
      _state = ResultState.loading;
      notifyListeners();
      final restaurants = await api.getDetails(id);
      if(restaurants.restaurant.id.isEmpty){
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Not Found Data';
      }else{
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailsResponse = restaurants;
      }
    }catch (e){
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}