
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:study/db/db_manager.dart';

abstract class BaseDBProvider{
  bool isTableExits = false;

  tableSqlString();

  tableName();

  Future<void>init(Database db);

  tableBaseString(String name, String columnId){
    return ''' 
      create table $name (
      $columnId integer primary key autoincrement,
    ''';
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExits = await DBManager.isTableExits(name);
    if(!isTableExits){
      Database db = await DBManager.getCurrentDatabase();
      await db.execute(createSql);
      await init(db);
    }
  }

  @mustCallSuper
  open() async{
    if(!isTableExits){
      await prepare(tableName(), tableSqlString());
    }
    return await DBManager.getCurrentDatabase();
  }

}