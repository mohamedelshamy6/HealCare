import 'package:heal_care/features/auth/data/models/patients_model.dart';

class DoctorBookingModel {
  String? id;
  String? doctorId;
  String? patientId;
  String? appointmentDate;
  String? appointmentTime;
  String? status;
  String? createdAt;

  PatientsModel? patient;

  DoctorBookingModel({
    this.id,
    this.doctorId,
    this.patientId,
    this.appointmentDate,
    this.appointmentTime,
    this.status,
    this.createdAt,
    this.patient, 
  });

  DoctorBookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    patientId = json['patient_id'];
    appointmentDate = json['appointment_date'];
    appointmentTime = json['appointment_time'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  
}
