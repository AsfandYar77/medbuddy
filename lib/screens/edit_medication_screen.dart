import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
  final _typeController = TextEditingController();
  final _dosageController = TextEditingController();
  final _intervalController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _atTime;
  DateTime? _dateTime;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.medication.name;
    _typeController.text = widget.medication.type!;
    _dosageController.text = widget.medication.dosage;
    _intervalController.text = widget.medication.atInterval as String;
    _notesController.text = widget.medication.notes!;
    _startDate = widget.medication.startDate;
    _endDate = widget.medication.endDate;
    _atTime = widget.medication.atTime as TimeOfDay?;
    _dateTime = widget.medication.dateTime;
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
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
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
                        //id: widget.medication.id,
                       // name: _nameController.text,
                        //dosage: _dosageController.text,
                       // frequency: _frequencyController.text,
                       // startDate: _startDate!,
                       // endDate: _endDate,
                       // notes: '',
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

