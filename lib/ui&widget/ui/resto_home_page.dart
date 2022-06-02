import 'package:restauranttt_sub3_rev3/provider&utils/restoprov/resto_provider.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/ui/resto_detail_page.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/ui/resto_pencarian_page.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/utils/constants.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/utils/result_state.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/widget/card_custm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestoHomePage extends StatelessWidget {
  const RestoHomePage({Key? key}) : super(key: key);
  static const routeName = '/restaurants';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("RestoSub3"),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(
                context,
                RestoPencarianPage.routeName,
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Consumer<RestoProvider>(builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                //loading widget
                return const Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.error) {
                // error widget
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.wifi_off, size: 50,),
                      Text('Yah Ga Ada Jaringan\nHarap Periksa Koneksi Internet kamu',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),)
                    ],
                  ),
                );
              } else if (state.state == ResultState.noData) {
                // error No Data
                return Center(child: Text(state.message));
              } else if (state.state == ResultState.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: state.restaurants.count,
                    itemBuilder: (context, index) {
                      final response = state.restaurants.restaurants[index];
                      return CardCustm(
                          pictureId: smallImageUrl + response.pictureId,
                          name: response.name,
                          city: response.city,
                          rating: response.rating,
                          onPress: () {
                            Navigator.pushNamed(
                                context, RestoDetailPage.routeName,
                                arguments: response);
                          });
                    });
              } else {
                return const Text("");
              }
            }),
          ),
        ],
      ),
    );
  }
}
