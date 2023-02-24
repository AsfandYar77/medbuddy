import 'package:flutter/material.dart';
import 'package:medbuddy/models/medication_model.dart';
import 'package:medbuddy/providers/medication_provider.dart';
import 'package:medbuddy/screens/add_medication_screen.dart';
import 'package:medbuddy/screens/medication_details_screen.dart';
import 'package:medbuddy/screens/medication_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MedicationProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'MedBuddy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MedicationScreen(),
          '/addMedication': (context) => const AddMedicationScreen(),
          '/medicationDetails': (context) {
            final medication = ModalRoute.of(context)!.settings.arguments as Medication;
            return MedicationDetailsScreen(medication: medication);
          },
        },
      ),
    );
  }
}
