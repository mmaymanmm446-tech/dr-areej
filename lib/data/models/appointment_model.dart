import 'package:flutter/material.dart';

class AppointmentModel {
  final String id;
  final String patientId;
  final String doctorId;
  final String patientName;
  final String doctorName;
  final DateTime date;
  final TimeOfDay time;
  final String status;
  final String? notes;
  final double? fee;
  final bool isPaid;
  final DateTime createdAt;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.patientName,
    required this.doctorName,
    required this.date,
    required this.time,
    required this.status,
    this.notes,
    this.fee,
    required this.isPaid,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'patientId': patientId,
        'doctorId': doctorId,
        'patientName': patientName,
        'doctorName': doctorName,
        'date': date.toIso8601String(),
        'time': '${time.hour}:${time.minute}',
        'status': status,
        'notes': notes,
        'fee': fee,
        'isPaid': isPaid,
        'createdAt': createdAt.toIso8601String(),
      };
}
