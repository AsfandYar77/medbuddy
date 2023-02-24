import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:medbuddy/models/medication_model.dart';
import 'package:medbuddy/providers/medication_provider.dart';
import 'package:provider/provider.dart';

class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen({Key? key}) : super(key: key);

  @override
  _AddMedicationScreenState createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _frequencyController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _frequencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final medicationProvider = Provider.of<MedicationProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Medication'),
        ),
        body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
          child: Form(key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Medication Name',),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a medication name';
                  }
                  return null;
                  },
              ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _dosageController,
                  decoration: const InputDecoration(
                    labelText: 'Dosage',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a dosage';
                    }
                    return null;
                    },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _frequencyController,
                  decoration: const InputDecoration(
                    labelText: 'Frequency',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a frequency';
                    }
                    return null;
                    },
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime(2050, 12, 31),
                            onConfirm: (date) {
                              setState(() {
                                _startDate = date;
                              }
                              );
                              },
                            currentTime: _startDate ?? DateTime.now(),
                            locale: LocaleType.en,
                          );
                          },
                        child: Text(_startDate != null
                            ? 'Start Date: ${_startDate!.toLocal()}'
                            : 'Select Start Date'),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: TextButton(onPressed: () {
                        DatePicker.showDatePicker(context, showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(2050, 12, 31),
                          onConfirm: (date) {setState(() {
                            _endDate = date;
                          });
                          },
                          currentTime: _endDate ?? DateTime.now(),
                          locale: LocaleType.en,);
                        },
                        child: Text(_endDate != null
                            ? 'End Date: ${_endDate!.toLocal()}'
                            : 'Select End Date'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          _startDate != null &&
                          _endDate != null) {
                        final medication = Medication(
                          name: _nameController.text,
                          dosage: _dosageController.text,
                          frequency: _frequencyController.text,
                          startDate: _startDate!,
                          endDate: _endDate!,
                          id: '',
                          notes: '',
                        );
                        medicationProvider.addMedication(medication);
                        Navigator.pop(context);
                      }
                      },
                    child: const Text('Add Medication'),
                  ),
                ),
              ],
            ),
          ),
        ),
        ),
    );
  }
}