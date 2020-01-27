import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trackly_app/models/database_helper_models.dart';

class DatabaseHelper {
  static final _databaseName = "trackly.db";
  static final _databaseVersion = 1;

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    var tables = new TableNames();
    var fields = new FieldNames();

    // activities table
    await db.execute('''
          CREATE TABLE ${tables.activities} (
            ${fields.columnId} INTEGER PRIMARY KEY,
            ${fields.category} TEXT NOT NULL,
            ${fields.date} TEXT NOT NULL,
            ${fields.time} TEXT NOT NULL,
            ${fields.subCategory} TEXT, 
            ${fields.duration} INTEGER NOT NULL,
            ${fields.notes} TEXT            
          )
          ''');

    // categories table
    await db.execute('''
          CREATE TABLE ${tables.categories} (
            ${fields.columnId} INTEGER PRIMARY KEY,
            ${fields.name} TEXT NOT NULL,         
          )
          ''');

    // sub-categories table
    await db.execute('''
          CREATE TABLE ${tables.subCategories} (
            ${fields.columnId} INTEGER PRIMARY KEY,
            ${fields.name} TEXT NOT NULL,         
          )
          ''');
  }

  // Helper methods

  /// Inserts a row in the database where each key in the Map is a column name
  /// and the value is the column value. The return value is the id of the
  ///  inserted row.
  Future<int> insert(Map<String, dynamic> row, String table) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount(String table) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row, String table) async {
    var fields = FieldNames();
    Database db = await instance.database;
    int id = row[fields.columnId];
    return await db
        .update(table, row, where: '${fields.columnId} = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id, String table) async {
    var fields = FieldNames();
    Database db = await instance.database;
    return await db
        .delete(table, where: '${fields.columnId} = ?', whereArgs: [id]);
  }
}
