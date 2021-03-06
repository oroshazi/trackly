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

  // SQL code to create the database tables
  Future _onCreate(Database db, int version) async {
    var tables = new Tables();
    var _initialCategories = [
      "Work",
      "Learning",
      "Cleaning",
      "Sport",
      "Entertainment",
      "Traveling"
    ];
    var _initialSubCategoriesWork = ["Meeting", "Coding", "research"];

    // activities table
    await db.execute('''
          CREATE TABLE ${Tables.ACTIVITIES} (
            ${Fields.COLUMN_ID} INTEGER PRIMARY KEY,
            ${Fields.CATEGORY} TEXT NOT NULL,
            ${Fields.DATE} TEXT NOT NULL,
            ${Fields.TIME} TEXT NOT NULL,
            ${Fields.SUB_CATEGORY} TEXT, 
            ${Fields.DURATION} INTEGER NOT NULL,
            ${Fields.NOTES} TEXT            
          )
          ''');

    // categories table
    await db.execute('''
          CREATE TABLE ${Tables.CATEGORIES} (
            ${Fields.COLUMN_ID} INTEGER PRIMARY KEY,
            ${Fields.NAME} TEXT NOT NULL         
          )
          ''');

    //Initial categories
    for (var i = 0; i < _initialCategories.length; i++) {
      await db.insert(Tables.CATEGORIES, {Fields.NAME: _initialCategories[i]});
    }

    // sub-categories table
    await db.execute('''
          CREATE TABLE ${Tables.SUB_CATEGORIES} (
            ${Fields.COLUMN_ID} INTEGER PRIMARY KEY,
            ${Fields.PARENT_CATEGORY_ID} INTEGER NOT NULL,         
            ${Fields.NAME} TEXT NOT NULL,         
            FOREIGN KEY(${Fields.PARENT_CATEGORY_ID}) REFERENCES ${Tables.CATEGORIES}(${Fields.COLUMN_ID})
          )
          ''');

    //Initial categories in work TODO: remove this
    for (var i = 0; i < _initialSubCategoriesWork.length; i++) {
      await db.insert(Tables.SUB_CATEGORIES, {
        Fields.PARENT_CATEGORY_ID: 1,
        Fields.NAME: _initialSubCategoriesWork[i]
      });
    }
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

  /// Executes raw SQL query and returns a list of rows that were found
  Future<List<Map<String, dynamic>>> rawQuery(String query) async {
    Database db = await instance.database;
    return await db.rawQuery(query);
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
    Database db = await instance.database;
    int id = row[Fields.COLUMN_ID];
    return await db
        .update(table, row, where: '${Fields.COLUMN_ID} = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id, String table) async {

    Database db = await instance.database;
    return await db
        .delete(table, where: '${Fields.COLUMN_ID} = ?', whereArgs: [id]);
  }
}
