import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final dbName = "database.db";
  static final dbVersion = 1;
  static final table = 'BooksList';
  static final bookID = 'Book';
  static final bookName = 'BookName';
  static final chaptersNumber = 'Chapters';
  static final bookSeq = 'Seq';

  String dbPath;

  DBProvider._(); // singleton

  static final DBProvider provider = DBProvider._();

  static Database instance; // singleton

  Future<Database> get db async {
    if (instance != null) return instance;

    await _copyDB(true);
    instance = await openDatabase(dbPath, version: dbVersion);

    return instance;
  }

  _copyDB(bool newCopy) async {
    if (newCopy) {
      await _newCopyDB();
    } else {
      await _copyIfNotDB();
    }
  }

  _copyIfNotDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, dbName);

    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", dbName));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }

    this.dbPath = path;
  }

  _newCopyDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, dbName);

    await deleteDatabase(path);

    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    ByteData data = await rootBundle.load(join("assets", dbName));
    List<int> bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes, flush: true);

    this.dbPath = path;
  }

  // Helpers
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await provider.db;
    return await db.insert(table, row);
  }

  allRows() async {
    Database db = await provider.db;
    return await db.query(table, orderBy: bookSeq);
  }

  Future<int> rowCount() async {
    Database db = await provider.db;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await provider.db;
    int id = row[bookID];
    return await db.update(table, row, where: '$bookID = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await provider.db;
    return await db.delete(table, where: '$bookID = ?', whereArgs: [id]);
  }
}
