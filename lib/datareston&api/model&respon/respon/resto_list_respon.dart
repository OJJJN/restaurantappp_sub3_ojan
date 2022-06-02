import 'package:restauranttt_sub3_rev3/datareston&api/model&respon/resto.dart';

class RestoListRespon {
  bool error;
  String message;
  int count;
  List<Restaurants> restaurants;

  RestoListRespon({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestoListRespon.fromJson(Map<String, dynamic> json) => RestoListRespon(
    message: json['message'],
    count: json['count'],
    error: json['error'],
    restaurants: List<Restaurants>.from(
      json['restaurants'].map((x) => Restaurants.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    'error': error,
    'message': message,
    'count': count,
    'restaurants': List<dynamic>.from(restaurants.map((e) => e.toJson())),
  };
}
