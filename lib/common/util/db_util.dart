import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBUtil {
  static Database? db;

  static Future<Database?> getInstance() async {
    if (db == null) {
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'prescribe_manager.db');
      try {
        db = await openDatabase(path,version: 1,onCreate: (Database db, int version){
          db.execute("""
          CREATE TABLE IF NOT EXISTS medicine (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT DEFAULT 药品名称 NOT NULL,
            sale_price REAL DEFAULT 0 NOT NULL,
            pur_price REAL DEFAULT 0 NOT NULL,
            img TEXT DEFAULT img NOT NULL
          );
        """);
          db.execute("""
          CREATE TABLE IF NOT EXISTS prescribe (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT DEFAULT 药方名称 NOT NULL,
            creat_time TEXT DEFAULT 2022 NOT NULL,
            sale_price REAL DEFAULT 0 NOT NULL,
            pur_price REAL DEFAULT 0 NOT NULL
          );
        """);
          db.execute("""
          CREATE TABLE IF NOT EXISTS sale_medicine (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            pid INTEGER NOT NULL,
            name TEXT DEFAULT 药品名称 NOT NULL,
            sale_price REAL DEFAULT 0 NOT NULL,
            pur_price REAL DEFAULT 0 NOT NULL,
            quantity INTEGER DEFAULT 0 NOT NULL,
            img TEXT DEFAULT img NOT NULL,
            CONSTRAINT sale_medicine_FK FOREIGN KEY (pid) REFERENCES prescribe(id)
          );
        """);
        });
      } catch (e){
        if (kDebugMode) {
          print("打开数据库出错：$e");
        }
      }
    }
    return db;
  }

}