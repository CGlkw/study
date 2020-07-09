import 'package:sqflite/sqflite.dart';
import 'package:study/db/db_provider.dart';

final String _tableName = "word";
final String columnId = "_id";
final String columnWord = "word";
final String columnDetail = "detail";
final String columnCore = "core";
final String columnCreateTime = "createTime";
final String columnIsDel = "isDel";

class Word {
  int id;
  String word;
  String detail;
  int core;
  int createTime;
  bool isDel;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnWord: word,
      columnDetail: detail,
      columnCore : core,
      columnCreateTime: createTime,
      columnIsDel: isDel == true ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Word();

  Word.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    word = map[columnWord];
    detail = map[columnDetail];
    core = map[columnCore];
    createTime = map[columnCreateTime];
    isDel = map[columnIsDel] == 1;
  }
}

class WordDao extends BaseDBProvider{

  Future<Word> insert(Word word) async {
    Database db = await getDataBase();
    word.id = await db.insert(_tableName, word.toMap());
    return word;
  }

  Future<List<Word>> list() async {
    Database db = await getDataBase();
    List<Map> maps = await db.query(_tableName,
        columns: [columnId, columnWord, columnDetail,columnCore,columnCreateTime,columnIsDel],
        orderBy: "$columnCore, $columnCreateTime",
        limit: 10
    );
    return maps.map((e) => Word.fromMap(e)).toList();
  }

  Future<Word> select(String word) async {
    Database db = await getDataBase();
    List<Map> maps = await db.query(_tableName,
        columns: [columnId, columnWord, columnDetail,columnCore,columnCreateTime,columnIsDel],
        where: "$columnWord = ?",
        whereArgs: [word]);
    if (maps.length > 0) {
      return new Word.fromMap(maps.first);
    }
    return null;
  }

  Future<Word> getWord(int id) async {
    Database db = await getDataBase();

    List<Map> maps = await db.query(_tableName,
        columns: [columnId, columnWord, columnDetail,columnCore,columnCreateTime,columnIsDel],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new Word.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    Database db = await getDataBase();
    return await db.delete(_tableName, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> update(Word word) async {
    Database db = await getDataBase();
    return await db.update(_tableName, word.toMap(),
        where: "$columnId = ?", whereArgs: [word.id]);
  }


  @override
  tableName() {
    return _tableName;
  }

  @override
  tableSqlString() {
    return tableBaseString(_tableName, columnId) +
    '''
    $columnWord text,
    $columnDetail text,
    $columnCore integer,
    $columnCreateTime integer,
    $columnIsDel integer
          )
    ''';
  }
}