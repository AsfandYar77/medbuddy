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
  //final _intervalController = TextEditingController();
  final _notesController = TextEditingController();
  final _intervals = [6, 8, 12, 24, 48, 72, 96, 120, 144, 168];
  int _atInterval = 0;
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
    //_intervalController.text = widget.medication.atInterval as String;
    _notesController.text = widget.medication.notes!;
    _startDate = widget.medication.startDate;
    _endDate = widget.medication.endDate;
    _atTime = widget.medication.atTime as TimeOfDay?;
    _dateTime = widget.medication.dateTime;
  }


  @override
  Widget build(BuildContext context) {
    final medicationProvider = Provider.of<MedicationProvider>(context, listen: false);
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
                  controller: _typeController,
                  decoration: const InputDecoration(
                    labelText: 'Type',
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
                //const SizedBox(height: 16.0),
                //Commenting out Interval Form Field as taking interval input via dropdown menu.
                /* TextFormField(
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
                ),*/
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Note',
                  ),
                  validator: (value) {
                    //Notes are Optional.
                    /*if (value == null || value.isEmpty) {
                      return 'Please Enter any Additional Notes/Instructions if any';
                    }*/
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
                              });
                            },
                            currentTime: _startDate ?? DateTime.now(),
                            locale: LocaleType.en,
                          );
                        },
                        child: Text(
                          _startDate != null
                              ? 'Start Date: ${DateFormat('dd-MM-yyyy ').format(_startDate!)}'
                              : 'Select Start Date',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16.0),
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
                                _endDate = date;
                              });
                            },
                            currentTime: _endDate ?? DateTime.now(),
                            locale: LocaleType.en,
                          );
                        },
                        child:
                        Text(_endDate != null
                            ? 'End Date: ${DateFormat('dd-MM-yyyy').format(_endDate!)}'
                            : 'Select End Date'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16.0),
                Row(
                  children: [
                    Expanded(
                      child:TextButton(
                          onPressed: () async {
                            _atTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (_atTime != null) {
                              setState(() {
                                _atTime = TimeOfDay(
                                  hour: _atTime!.hour,
                                  minute: _atTime!.minute,
                                );
                              });
                            }
                          },
                          child:
                          Text(_atTime != null
                              ? 'Start Time: ${_atTime!.format(context)}'
                              : 'Select Time'
                          )

                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Every:"),
                    DropdownButton(
                      hint: _atInterval == 0
                          ? Text("Please Select an Interval")
                          : null,
                      value: _atInterval == 0 ? null : _atInterval,
                      items: _intervals.map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          _atInterval = newVal!;
                        });
                      },
                    ),
                    Text(
                      _atInterval <= 48
                          ? "$_atInterval hours"
                          : _atInterval <= 336
                          ? "${(_atInterval / 24).floor()} days"
                          : "${(_atInterval / 168).floor()} weeks",
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
                          notificationIDs: [],
                          name: _nameController.text,
                          type: _typeController.text,
                          dosage: _dosageController.text,
                          notes: _notesController.text,
                          startDate: _startDate!,
                          endDate: _endDate!,
                          atTime: _atTime,
                          dateTime: _dateTime,
                          atInterval: _atInterval,
                          //id: UniqueKey().toString(),
                          //name: _nameController.text,
                          // dosage: _dosageController.text,
                          // frequency: _frequencyController.text,
                          // startDate: _startDate!,
                          // endDate: _endDate!,
                          // notes: _notesController.text,
                        );

                        medicationProvider.updateMedication(medication);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Update Medication'),
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

