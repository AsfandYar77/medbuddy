import 'package:flutter/material.dart';
import 'package:medbuddy/providers/medication_provider.dart';
import 'package:medbuddy/screens/add_medication_screen.dart';
import 'package:medbuddy/widgets/app_drawer.dart';
import 'package:medbuddy/widgets/medication_tile.dart';
import 'package:provider/provider.dart';

class MedicationScreen extends StatelessWidget {
  const MedicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final medicationProvider = Provider.of<MedicationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MedBuddy'),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: medicationProvider.medications.length,
                itemBuilder: (context, index) {
                  final medication = medicationProvider.medications[index];
                  return MedicationTile(medication: medication);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMedicationScreen(),
                  ),
                );
              },
              child: const Text('Add Medication'),
            ),
          ],
        ),
      ),
    );
  }
}
