class DoctorAppointmentsModel {
  String? id;
  String? doctorId;
  String? patientId;
  String? appointmentDate;
  String? appointmentTime;
  String? status;
  String? createdAt;

  DoctorAppointmentsModel(
      {this.id,
      this.doctorId,
      this.patientId,
      this.appointmentDate,
      this.appointmentTime,
      this.status,
      this.createdAt});

  DoctorAppointmentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    patientId = json['patient_id'];
    appointmentDate = json['appointment_date'];
    appointmentTime = json['appointment_time'];
    status = json['status'];
    createdAt = json['created_at'];
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
    return data;
  }
}
