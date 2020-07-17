import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:study/db/db_provider.dart';
import 'package:study/utils/TimeUtils.dart';

final String _tableName = "book";
final String columnId = "_id";
final String columnName = "name";
final String columnColor = "color";
final String columnCount = "count";
final String columnWord = "word";
final String columnIsDefault = "isDefault";

final String columnCreateTime = "createTime";
final String columnIsDel = "isDel";

class Book {
  int id;
  String name;
  MaterialColor color;
  int count;
  String word;
  bool isDefault;
  int createTime;
  bool isDel;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnColor: Colors.primaries.indexOf(color),
      columnCount:count,
      columnWord:word,
      columnIsDefault: isDefault == true ? 1: 0,
      columnCreateTime: createTime,
      columnIsDel: isDel == true ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Book();

  Book.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    color = Colors.primaries[map[columnColor]];
    count = map[columnCount];
    word = map[columnWord];
    isDefault= map[columnIsDefault] == 0;
    createTime = map[columnCreateTime];
    isDel = map[columnIsDel] == 1;
  }
}

class BookDao extends BaseDBProvider{

  Future<Book> insert(Book word) async {
    Database db = await getDataBase();
    word.id = await db.insert(_tableName, word.toMap());
    return word;
  }

  Future<List<Book>> list() async {
    Database db = await getDataBase();
    List<Map> maps = await db.query(_tableName,
        columns: [columnId, columnName,columnIsDefault,columnCreateTime,columnIsDel],
    );
    return maps.map((e) => Book.fromMap(e)).toList();
  }

  Future<Book> getDefaultBook() async {
    Database db = await getDataBase();
    List<Map> maps = await db.query(_tableName,
        columns: [columnId, columnName,columnIsDefault,columnCreateTime,columnIsDel],
        where: "$columnIsDefault = 1",
    );
    if (maps.length > 0) {
      return new Book.fromMap(maps.first);
    }
    return null;
  }

  Future<Book> getBook(int id) async {
    Database db = await getDataBase();
    List<Map> maps = await db.query(_tableName,
        columns: [columnId, columnName,columnIsDefault,columnCreateTime,columnIsDel],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new Book.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    Database db = await getDataBase();
    return await db.delete(_tableName, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> update(Book book) async {
    Database db = await getDataBase();
    return await db.update(_tableName, book.toMap(),
        where: "$columnId = ?", whereArgs: [book.id]);
  }


  @override
  tableName() {
    return _tableName;
  }

  @override
  tableSqlString() {
    return tableBaseString(_tableName, columnId) +
    '''
    $columnName text,
    $columnIsDefault integer,
    $columnCreateTime integer,
    $columnIsDel integer
          )
    ''';
  }

  @override
  Future<void> init(Database db) async {
    Book book = Book();
    book.isDefault = true;
    book.name = "我的生词本";
    book.count = 0;
    book.word = "M";
    book.color = Colors.blue;
    book.createTime = TimeUtils.currentTimeMillis();
    await db.insert(_tableName, book.toMap());
  }
}