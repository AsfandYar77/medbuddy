import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/medication_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  DatabaseHelper._privateConstructor();


  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'medications.db'),
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE medications(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        dosage TEXT,
        frequency TEXT,
        start_date INTEGER,
        end_date INTEGER,
        notes TEXT
      )
    ''');
  }

  Future<int> addMedication(Medication medication) async {
    final db = await database;
    return db.insert('medications', medication.toMap());
  }

  Future<int> updateMedication(Medication medication) async {
    final db = await database;
    return db.update(
      'medications',
      medication.toMap(),
      where: 'id = ?',
      whereArgs: [medication.notificationIDs],
    );
  }

  Future<int> deleteMedication(int id) async {
    final db = await database;
    return db.delete(
      'medications',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Medication>> getMedications() async {
    final db = await database;
    final List<Map<String, dynamic>> medicationData = await db.query('medications');
    return medicationData.map((data) => Medication.fromMap(data)).toList();
  }
}
