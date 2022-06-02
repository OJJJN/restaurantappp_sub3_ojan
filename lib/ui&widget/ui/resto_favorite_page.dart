import 'package:restauranttt_sub3_rev3/provider&utils/restoprov/resto_database_provider.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/ui/resto_detail_page.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/utils/result_state.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/utils/theme.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/widget/card_custm.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/widget/plat_widget.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class RestoFavoritePage extends StatelessWidget {
  static const String routeName = '/resto_favorite_page';

  const RestoFavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return PlatWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorite'),
        ),
        body: _buildList(context));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Favorite'),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestoDatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.favorite.length,
            itemBuilder: (context, index) {
              final result = provider.favorite[index];
              return CardCustm(
                  pictureId: smallImageUrl + result.pictureId,
                  name: result.name,
                  city: result.city,
                  rating: result.rating,
                  onPress: () {
                    Navigator.pushNamed(context, RestoDetailPage.routeName,
                        arguments: result);
                  });
            },
          );
        } else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Data favoritenya belum ada nih', style: TextStyle(
                    fontSize: 16,
                    fontWeight: bold
                ),)
              ],
            ),
          );
        }
      },
    );
  }
}
