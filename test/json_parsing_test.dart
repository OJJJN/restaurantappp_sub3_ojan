import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restauranttt_sub3_rev3/datareston&api/api/api.dart';
import 'package:restauranttt_sub3_rev3/datareston&api/model&respon/respon/resto_list_respon.dart';
import 'json_parsing_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Fetch restaurant api', () {
    final restaurantTest = {
      "error": false,
      "message": "success",
      "count": 20,
      "restaurants": [
        {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description":
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
          "pictureId": "14",
          "city": "Medan",
          "rating": 4.2
        },
      ]
    };

    test('must contain a list of restaurant when api successful', () async {
      final api = Api();
      final client = MockClient();

      when(
        client.get(
          Uri.parse(Api.baseUrl + Api.endpointList),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(restaurantTest), 200));

      expect(await api.getTopHeadLines(client), isA<RestoListRespon>());
    });

    test('must contain a list of restaurant when api failed', () {
      //arrange
      final api = Api();
      final client = MockClient();

      when(
        client.get(
          Uri.parse(Api.baseUrl + Api.endpointList),
        ),
      ).thenAnswer((_) async =>
          http.Response('Failed to load list of restaurants', 404));

      var restaurantActual = api.getTopHeadLines(client);
      expect(restaurantActual, throwsException);
    });

    test('must contain a list of restaurant when no internet connection', () {
      //arrange
      final api = Api();
      final client = MockClient();

      when(
        client.get(
          Uri.parse(Api.baseUrl + Api.endpointList),
        ),
      ).thenAnswer(
          (_) async => throw const SocketException('No Internet Connection'));

      var restaurantActual = api.getTopHeadLines(client);
      expect(restaurantActual, throwsException);
    });
  });
}
