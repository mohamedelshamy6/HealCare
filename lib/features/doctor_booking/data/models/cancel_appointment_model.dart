class CancelAppointmentModel {
  bool? success;
  String? message;
  Appointment? appointment;

  CancelAppointmentModel({this.success, this.message, this.appointment});

  CancelAppointmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    appointment = json['appointment'] != null
        ? Appointment.fromJson(json['appointment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (appointment != null) {
      data['appointment'] = appointment!.toJson();
    }
    return data;
  }
}

class Appointment {
  String? id;
  String? doctorId;
  String? patientId;
  String? appointmentDate;
  String? appointmentTime;
  String? status;
  String? createdAt;
  String? updatedAt;

  Appointment(
      {this.id,
      this.doctorId,
      this.patientId,
      this.appointmentDate,
      this.appointmentTime,
      this.status,
      this.createdAt,
      this.updatedAt});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    patientId = json['patient_id'];
    appointmentDate = json['appointment_date'];
    appointmentTime = json['appointment_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doctor_id'] = doctorId;
    data['patient_id'] = patientId;
    data['appointment_date'] = appointmentDate;
    data['appointment_time'] = appointmentTime;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
