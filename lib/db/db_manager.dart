
import 'dart:io';

import 'package:sqflite/sqflite.dart';

class DBManager{
  
  static const int _VERSION = 1;
  
  static const String _DB_NAME = "study.db";
  
  static Database _database;
  
  static init() async{
    var databasePath = await getDatabasesPath();
    String dbName = _DB_NAME;
    String path  = databasePath + dbName;
    if(Platform.isIOS){
      path = databasePath + "/" + dbName;
    }
    
    _database = await openDatabase(path, version: _VERSION, onCreate:(Database db, int version){

    });
  }

  static isTableExits(String tableName) async{
    await getCurrentDatabase();
    String sql =
        "select * from Sqlite_master where type = 'table' and name = '$tableName'";
    var res = await _database.rawQuery(sql);
    return res != null && res.length > 0;
  }

  static getCurrentDatabase() async {
    if(_database == null){
      await init();
    }
    return _database;
  }

  static close(){
    _database?.close();
    _database =null;
  }
}