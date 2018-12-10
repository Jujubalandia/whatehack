import 'package:whatehack/src/models/item_model.dart';
import 'package:whatehack/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test_api/test_api.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';


void main() {
  test('FetchTopIds returns a list of Kids', () async {
    // setup test case 
    //final sum = 1 + 3;

    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
       return Response(json.encode([1,2,3,4]), 200);
    });

    final ids = await newsApi.fetchTopsIds();
    // expectation
    //expect(sum, 4);
    expect(ids, [1,2,3,4]);

  });

  test('Fetch Returns a item model',  () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap),200);
    });
    final item = await newsApi.fetchItem(999);

    expect(item.id, 123);
  });
} 