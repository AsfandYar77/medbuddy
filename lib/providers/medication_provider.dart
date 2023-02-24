import 'package:flutter/foundation.dart';
import 'package:medbuddy/models/medication_model.dart';
import 'package:medbuddy/utils/database_helper.dart';


class MedicationProvider extends ChangeNotifier {
  List<Medication> _medications = [];

  List<Medication> get medications => _medications;

  DatabaseHelper database = DatabaseHelper();

  void addMedication(Medication medication) {
    _medications.add(medication);
    notifyListeners();
  }

  void updateMedication(Medication medication) {
    final index =
    _medications.indexWhere((element) => element.id == medication.id);
    _medications[index] = medication;
    notifyListeners();
  }

  Future<void> deleteMedication(String id) async {
    _medications.removeWhere((element) => element.id == id);
    notifyListeners();
    final db = await database.database;
    await db.delete('medications', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> loadMedications() async {
    final db = await database.database;
    final List<Map<String, dynamic>> medicationData =
    await db.query('medications');
    _medications =
        medicationData.map((data) => Medication.fromMap(data)).toList();
    notifyListeners();
  }
}
