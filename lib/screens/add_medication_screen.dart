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
  final _typeController = TextEditingController();
  final _dosageController = TextEditingController();
  final _intervalController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _atTime;
  DateTime? _dateTime;





  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _dosageController.dispose();
    _intervalController.dispose();
    _notesController.dispose();
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
                    labelText: 'type',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Type';
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
                  controller: _intervalController,
                  decoration: const InputDecoration(
                    labelText: 'Interval',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Interval';
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
                            minTime: DateTime(1900, 01, 01),
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
                ElevatedButton(
                  onPressed: () async {
                    _atTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (_atTime != null) {
                      setState(() {
                        _dateTime = DateTime(
                          _dateTime!.year,
                          _dateTime!.month,
                          _dateTime!.day,
                          _atTime!.hour,
                          _atTime!.minute,
                        );
                      });
                    }
                  },
                  child: Text(_dateTime != null ? _dateTime.toString() : 'Select Time'),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          _startDate != null &&
                          _endDate != null) {
                        final medication = Medication(
                            notificationIDs: [],
                            name: _nameController.text,
                            type: _typeController.text,
                            dosage: _dosageController.text,
                            startDate: _startDate!,
                            endDate: _endDate!,
                            atTime: '',
                          dateTime: _dateTime,
                            atInterval: null,
                            notes: _notesController.text,
                          //id: UniqueKey().toString(),
                          //name: _nameController.text,
                         // dosage: _dosageController.text,
                         // frequency: _frequencyController.text,
                         // startDate: _startDate!,
                         // endDate: _endDate!,
                         // notes: _notesController.text,
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