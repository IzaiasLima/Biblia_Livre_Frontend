import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.getInstance();
  static final dbName = "database.db";
  static final isNewCopy = false;

  DatabaseHelper.getInstance();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();

    return _db;
  }

  Future _initDb() async {
    // String databasesPath = await getDatabasesPath();
    // String path = join(databasesPath, dbName);
    String path = (isNewCopy) ? await _alwaysCopy() : await _copyIfNotExists();

    var db = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
     // await _executeSql(db, "create");
  }

  void _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion == 1 && newVersion == 2) {
      // return await _executeSql(db, "update");
    }
  }

  _executeSql(Database db, String sqlFile) async {
    String path = "assets/sql/$sqlFile.sql";
    String s = await rootBundle.loadString(path);

    List<String> sql = s.split(";");

    for (String s in sql) {
      if (s.trim().isNotEmpty) {
        await db.execute(s);
      }
    }
  }

  _copyIfNotExists() async {
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

    return path;
  }

  _alwaysCopy() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, dbName);

    await deleteDatabase(path);

    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {
    }

    ByteData data = await rootBundle.load(join("assets", dbName));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes, flush: true);

    return path;
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
