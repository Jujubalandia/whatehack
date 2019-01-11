import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache {
  Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE Items
           (
              id INTEGER PRIMARY KEY,  
              deleted INTEGER,
              type INTEGER
              time INTEGER,                        
              text TEXT,      
              dead INTEGER,      
              url TEXT,
              title TEXT,
              score INTEGER
           )
        """);
        // deleted INTEGER,
        // type TEXT,
        // by TEXT,
        // time INTEGER,
        // text TEXT,
        // dead INTEGER,
        // parent INTEGER,
        // kids BLOB,
        // url TEXT,
        // score INTEGER,
        //descendents INTEGER
      },
    );
  }

  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert(
      "Items",
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  @override
  Future<List<int>> fetchTopIds() {
    // TODO: implement fetchTopsIds
    return null;
  }

  Future<int> clear() {
    return db.delete("Items");
  }


}

final newsDbProvider = NewsDbProvider();
