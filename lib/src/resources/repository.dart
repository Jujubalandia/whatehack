import 'dart:async';
import 'news_api_provider.dart';
import 'new_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopsIds() {
    return apiProvider.fetchTopsIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    var item = await dbProvider.fetchItem(id);
    if (item != null) {
      return item;
    }

    item = await apiProvider.fetchItem(id);
    dbProvider.addItem(item);

    return item;
  }
}


abstract class Source {
  Future <List<int>> fetchTopsIds();
  Future <ItemModel> fetchItem(int id);
}

abstract class Cache {

}
