import 'package:heal_care/features/auth/data/models/doctors_model.dart';

class AppointmentModel {
  final String id;
  final String doctorId;
  final String patientId;
  final String appointmentDate;
  final String appointmentTime;
  final String status;
  final String createdAt;

  DoctorsModel? doctor;  

  AppointmentModel({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.status,
    required this.createdAt,
    this.doctor,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      doctorId: json['doctor_id'],
      patientId: json['patient_id'],
      appointmentDate: json['appointment_date'],
      appointmentTime: json['appointment_time'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }
}