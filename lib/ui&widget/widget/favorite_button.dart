import 'package:restauranttt_sub3_rev3/datareston&api/model&respon/resto.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/restoprov/resto_database_provider.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final Restaurants favorite;

  const FavoriteButton({Key? key, required this.favorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestoDatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(favorite.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return isFavorite
                ? InkWell(
              onTap: () {
                provider.removeFavorite(favorite.id);
                Fluttertoast.showToast(
                    msg: 'Mengahapus dari favorite',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kGreenColor,
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.white,
                ),
              ),
            )
                : InkWell(
              onTap: () {
                provider.addFavorite(favorite);
                Fluttertoast.showToast(
                    msg: 'Yeay, Berhasil Ditambahkan Ke Favorite',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kGreenColor,
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.favorite_outline_rounded,
                  color: Colors.white,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
