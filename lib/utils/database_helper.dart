import 'dart:io';
import 'package:medbuddy/models/medication_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  DatabaseHelper._internal();

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'medbuddy.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE medications(id TEXT PRIMARY KEY, name TEXT, dose TEXT, schedule TEXT, start_date INTEGER, end_date INTEGER)');
  }

  static Future<void> deleteDatabase(String path) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'medbuddy.db');
    await deleteDatabase(path);
  }

  static DatabaseHelper getInstance() {
    return _instance;
  }
}