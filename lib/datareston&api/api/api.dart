import 'dart:convert';
import 'dart:async';

import 'package:restauranttt_sub3_rev3/datareston&api/model&respon/respon/resto_details_response.dart';
import 'package:restauranttt_sub3_rev3/datareston&api/model&respon/respon/resto_list_respon.dart';
import 'package:restauranttt_sub3_rev3/datareston&api/model&respon/respon/resto_list_pencarian.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const endpointList = 'list';

  ///get lost restaurant
  Future<RestoListRespon> getTopHeadLines(http.Client client) async{
    final response = await client.get(Uri.parse(baseUrl + endpointList));
    try{
      if(response.statusCode == 200){
        return RestoListRespon.fromJson(json.decode(response.body));
      }else{
        throw Exception('Failed to load top headlines');
      }
    }catch(e){
      rethrow;
    }
  }

  ///get search
  Future<RestoListPencarian> getSearch(String query) async {
    final response = await http.get(Uri.parse("${baseUrl}search?q=${query}"));
    try{
      if(response.statusCode == 200){
        return RestoListPencarian.fromJson(json.decode(response.body));
      }else{
        throw Exception('Failed to load result search.');
      }
    } on Error {
      rethrow;
    }
  }

  Future<RestaurantDetailsResponse> getDetails(String id) async{
    final response = await http.get(Uri.parse(baseUrl + 'detail/$id')).timeout((const Duration(seconds: 5)));
    try{
      if(response.statusCode == 200){
        return RestaurantDetailsResponse.fromJson(json.decode(response.body));
      }else{
        throw Exception('Failed to load details.');
      }
    }on Error {
      rethrow;
    }
  }
}