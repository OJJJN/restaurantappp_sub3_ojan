import 'package:restauranttt_sub3_rev3/datareston&api/model&respon/resto_detail.dart';

class RestaurantDetailsResponse{
  bool error;
  String message;
  Restaurant restaurant;

  RestaurantDetailsResponse({
    required this.error,
    required this.message,
    required this.restaurant
  });

  factory RestaurantDetailsResponse.fromJson(Map<String, dynamic> json) => RestaurantDetailsResponse(
    error: json['error'],
    message: json['message'],
    restaurant: Restaurant.fromJsonDetail(json['restaurant']),
  );

  Map<String, dynamic> toJson() => {
    'error': error,
    'message': message,
    'restaurant': restaurant.toJson(),
  };
}