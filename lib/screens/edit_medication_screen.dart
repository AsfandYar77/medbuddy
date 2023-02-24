import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medbuddy/models/medication_model.dart';
import 'package:medbuddy/providers/medication_provider.dart';
import 'package:provider/provider.dart';

class EditMedicationScreen extends StatefulWidget {
  final Medication medication;

  const EditMedicationScreen({Key? key, required this.medication}) : super(key: key);

  @override
  _EditMedicationScreenState createState() => _EditMedicationScreenState();
}

class _EditMedicationScreenState extends State<EditMedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _frequencyController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.medication.name;
    _dosageController.text = widget.medication.dosage;
    _frequencyController.text = widget.medication.frequency;
    _startDate = widget.medication.startDate;
    _endDate = widget.medication.endDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Medication'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Medication Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter medication name';
                    }
                    return null;
                    },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _dosageController,
                  decoration: const InputDecoration(
                    labelText: 'Dosage',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter dosage';
                    }
                    return null;
                    },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _frequencyController,
                  decoration: const InputDecoration(
                    labelText: 'Frequency',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter frequency';
                    }
                    return null;
                    },
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () async {
                    final initialDate = _startDate ?? DateTime.now();
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: initialDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _startDate = pickedDate;
                      });
                    }
                    },
                  child: Text(_startDate != null
                      ? 'Start Date: ${DateFormat.yMd().format(_startDate!)}'
                      : 'Select Start Date'),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () async {
                    final initialDate = _endDate ?? DateTime.now();
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: initialDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {                      setState(() {
                      _endDate = pickedDate;
                    });
                    }
                    },
                  child: Text(_endDate != null
                      ? 'End Date: ${DateFormat.yMd().format(_endDate!)}'
                      : 'Select End Date'),
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final medication = Medication(
                        id: widget.medication.id,
                        name: _nameController.text,
                        dosage: _dosageController.text,
                        frequency: _frequencyController.text,
                        startDate: _startDate!,
                        endDate: _endDate,
                        notes: '',
                      );
                      final medicationProvider = Provider.of<MedicationProvider>(context, listen: false);
                      medicationProvider.updateMedication(medication);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

