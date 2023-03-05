import 'package:flutter/material.dart';
import 'package:medbuddy/models/medication_model.dart';
import 'package:medbuddy/screens/edit_medication_screen.dart';

class MedicationTile extends StatelessWidget {
  final Medication medication;

  const MedicationTile({Key? key, required this.medication}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditMedicationScreen(medication: medication),
            ),
          );
        },
        child: ListTile(
          title: Text(
            medication.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Dosage: ${medication.dosage}, Frequency: ${medication.getFrequencyString(medication.atInterval)}',
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          trailing: Icon(Icons.edit),
        ),
      ),
    );
  }
}
