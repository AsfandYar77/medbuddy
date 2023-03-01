import 'package:flutter/foundation.dart';
import 'package:medbuddy/models/medication_model.dart';
import 'package:medbuddy/utils/database_helper.dart';

class MedicationProvider extends ChangeNotifier {
  List<Medication> _medications = [];

  List<Medication> get medications => _medications;

  DatabaseHelper database = DatabaseHelper.instance;

  void addMedication(Medication medication) async {
    _medications.add(medication);
    notifyListeners();
    final db = await database.database;
    await db.insert('medications', medication.toMap());
  }

  void updateMedication(Medication medication) async {
    final index = _medications.indexWhere((element) => element.notificationIDs == medication.notificationIDs);
    _medications[index] = medication;
    notifyListeners();
    final db = await database.database;
    await db.update('medications', medication.toMap(), where: 'id = ?', whereArgs: [medication.notificationIDs]);
  }

  Future<void> deleteMedication(String id) async {
    _medications.removeWhere((element) => element.notificationIDs == id);
    notifyListeners();
    final db = await database.database;
    await db.delete('medications', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> loadMedications() async {
    final db = await database.database;
    final List<Map<String, dynamic>> medicationData = await db.query('medications');
    _medications = medicationData.map((data) => Medication.fromMap(data)).toList();
    notifyListeners();
  }

  Future<void> init() async {
    await loadMedications();
  }
}
