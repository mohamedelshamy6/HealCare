import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/patient_booking/data/model/appoientment_model.dart';

class AppointmentWithDoctorModel {
  final AppointmentModel appointment;
  final DoctorsModel doctor;

  AppointmentWithDoctorModel({
    required this.appointment,
    required this.doctor,
  });
  
}
