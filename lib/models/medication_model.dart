import 'package:flutter/material.dart';

class Medication {
  final List<dynamic>? notificationIDs;
  final String name;
  final String? type;
  final String dosage;
  final DateTime startDate;
  final DateTime? endDate;
  final TimeOfDay? atTime;
  final DateTime? dateTime;
  final int? atInterval;
  String? notes;

  Medication({
    required this.notificationIDs,
    required this.name,
    required this.type,
    required this.dosage,
    required this.startDate,
    required this.endDate,
    required this.atTime,
    required this.dateTime,
    required this.atInterval,
    this.notes,
  });

  //get methods

  getIDs() {
    return notificationIDs;
  }

  String getName() {
    return name!;
  }

  String getType() {
    return type!;
  }

  String getDosage() {
    return dosage!;
  }

  DateTime getStartDate() {
    return startDate;
  }

  DateTime? getEndDate() {
    return endDate;
  }

  TimeOfDay? getAtTime() {
    return atTime;
  }

  DateTime? getdateTime() {
    return endDate;
  }

  int? getAtInterval() {
    return atInterval;
  }

  String? getNotes() {
    return notes;
  }



  factory Medication.fromMap(Map<String, dynamic> json) => Medication(
    notificationIDs: json["notificationIDs"],
    name: json['name'],
    type: json['type'],
    dosage: json['dosage'],
    startDate: DateTime.parse(json['startDate']),
    endDate: DateTime.parse(json['endDate']),
    atTime: json['atTime'],
    dateTime: DateTime.parse(json['dateTime']),
    atInterval: json['atInterval'],
    notes: json['notes'],
  );

  Map<String, dynamic> toMap() => {
    'id': notificationIDs,
    'name': name,
    'type': type,
    'dosage': dosage,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate?.toIso8601String(),
    'atTime': atTime,
    'dateTime': dateTime?.toIso8601String(),
    'atInterval': atInterval,
    'notes': notes,
  };
  String getFrequencyString(int? interval) {
    if (interval == null) {
      return 'Unknown';
    } else if (interval == 24) {
      return 'Once a day';
    } else if (interval == 12) {
      return 'Twice a day';
    } else if (interval == 8) {
      return '3 times a day';
    } else if (interval == 6) {
      return '4 times a day';
    } else if (interval % 24 == 0) {
      final days = interval ~/ 24;
      if (days == 1) {
        return 'Once a day';
      } else if (days == 2) {
        return 'Twice a day';
      } else {
        return 'Every $days days';
      }
    } else if (interval % 168 == 0) {
      final weeks = interval ~/ 168;
      if (weeks == 1) {
        return 'Once a week';
      } else {
        return 'Every $weeks weeks';
      }
    } else {
      return 'Unknown';
    }
  }
}
