import 'package:restauranttt_sub3_rev3/datareston&api/model&respon/resto.dart';

class RestoListPencarian {
  bool error;
  int founded;
  List<Restaurants> restaurants;

  RestoListPencarian({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestoListPencarian.fromJson(Map<String, dynamic> json) =>
      RestoListPencarian(
        error: json['error'],
        founded: json['founded'],
        restaurants: List<Restaurants>.from(
            json["restaurants"].map((x) => Restaurants.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    'error': error,
    'founded': founded,
    'restaurants': List<dynamic>.from(restaurants.map((x) => x.toJson()))
  };
}
