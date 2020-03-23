import 'dart:io';
import 'package:flutter/services.dart';
import 'package:freebible/models/bible.dart';
import 'package:freebible/models/book.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final dbName = "database.db";
  static final dbVersion = 1;

  static final bibleTable = 'Bible';
  static final bookTable = 'BooksList';

  static final oldTestament = 1;
  static final newTestament = 2;

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
    } catch (error) {
      print(error);
    }

    ByteData data = await rootBundle.load(join("assets", dbName));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes, flush: true);

    this.dbPath = path;
  }

  // --- Helpers ---

  allBooksList() async {
    Database db = await provider.db;
    var result = await db.query(bookTable, orderBy: bookSeq);
    List list =
        result.isNotEmpty ? result.map((l) => Book.fromMap(l)).toList() : [];
    return list;
  }

  oldTestamentList() async {
    Database db = await provider.db;
    var result = await db.query(bookTable,
        where: 'Testament = ?', whereArgs: [oldTestament], orderBy: bookID);
    List list =
        result.isNotEmpty ? result.map((l) => Book.fromMap(l)).toList() : [];
    return list;
  }

  newTestamentList() async {
    Database db = await provider.db;
    var result = await db.query(bookTable,
        where: 'Testament = ?', whereArgs: [newTestament], orderBy: bookID);
    List list =
        result.isNotEmpty ? result.map((l) => Book.fromMap(l)).toList() : [];
    return list;
  }

  oneBook(bookID) async {
    Database db = await provider.db;
    return await db.query(bookTable, where: 'Book = ?', whereArgs: [bookID]);
  }

  Future<List<Bible>> allVerses(bookID, chapter) async {
    Database db = await provider.db;
    var result = await db.query(bibleTable,
        where: 'Book = ? and Chapter = ?', whereArgs: [bookID, chapter]);

    List list =
        result.isNotEmpty ? result.map((l) => Bible.fromMap(l)).toList() : [];
    return list;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await provider.db;
    return await db.insert(bibleTable, row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await provider.db;
    int id = row[bookID];
    return await db
        .update(bibleTable, row, where: '$bookID = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await provider.db;
    return await db.delete(bibleTable, where: '$bookID = ?', whereArgs: [id]);
  }
}
