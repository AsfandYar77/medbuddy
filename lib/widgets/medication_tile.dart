import 'package:flutter/material.dart';
import 'package:medbuddy/models/medication_model.dart';
import 'package:medbuddy/screens/edit_medication_screen.dart';

class MedicationTile extends StatelessWidget {
  final Medication medication;

  const MedicationTile({Key? key, required this.medication}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(medication.name),
      subtitle: Text('Dosage: ${medication.dosage}, Frequency: ${medication.atInterval}'),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditMedicationScreen(medication: medication),
            ),
          );
        },
      ),
    );
  }
}
