import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/restoprov/resto_pencarian_provider.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/utils/result_state.dart';
import 'package:restauranttt_sub3_rev3/provider&utils/utils/constants.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/widget/card_custm.dart';
import 'package:restauranttt_sub3_rev3/ui&widget/ui/resto_detail_page.dart';

class RestoPencarianPage extends StatefulWidget {
  static const routeName = '/resto_pencarian_page';

  const RestoPencarianPage({Key? key}) : super(key: key);

  @override
  _RestoPencarianPageState createState() => _RestoPencarianPageState();
}

class _RestoPencarianPageState extends State<RestoPencarianPage> {
  String queries = '';
  final TextEditingController _controller = TextEditingController();

  Widget _listSearch(BuildContext context) {
    return Consumer<RestoPencarianProvider>(
      builder: (context, provider, _) {
        if (provider.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.state == ResultState.hasData) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: provider.result?.restaurants.length,
                itemBuilder: (context, index) {
                  var response = provider.result!.restaurants[index];
                  return CardCustm(
                      pictureId: smallImageUrl + response.pictureId,
                      name: response.name,
                      city: response.city,
                      rating: response.rating,
                      onPress: () {
                        Navigator.pushNamed(context, RestoDetailPage.routeName,
                            arguments: response);
                      });
                }),
          );
        } else if (provider.state == ResultState.noData) {
          return Center(
            child: Text(provider.message),
          );
        } else if (provider.state == ResultState.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.search, size: 70,),
                Text("Diketik dibagian pencarian yahh!!")
              ],
            ),
          );
        } else {
          return const Center(
            child: Text(''),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Timer? _debounce;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Resto'),
      ),
      body: Center(
          child: Column(
            children: [
              Consumer<RestoPencarianProvider>(
                builder: (context, state, _) {
                  return Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            // color: Colors.red[500],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: ListTile(
                          leading: const Icon(
                            Icons.search,
                            size: 30,
                          ),
                          title: TextField(
                            controller: _controller,
                            onChanged: (String value) {
                              setState(() {
                                queries = value;
                              });
                              if (value != '') {
                                state.fetchSearchRestaurant(value);
                              }
                            },
                            decoration: const InputDecoration(
                                hintText: "Cari Resto",
                                border: InputBorder.none),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              if (queries != '') {
                                _controller.clear();
                                setState(() {
                                  queries = '';
                                });
                              }
                            },
                            icon: Icon(Icons.cancel_outlined, size: 30),
                          )));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: _listSearch(context),
                ),
              ),
            ],
          )),
    );
  }
}
