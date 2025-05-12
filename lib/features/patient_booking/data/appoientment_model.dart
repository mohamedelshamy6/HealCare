class AppointmentModel {
  final String id;
  final String doctorId;
  final String patientId;
  final String appointmentDate;
  final String appointmentTime;
  final String status;
  final String createdAt;

  AppointmentModel({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.status,
    required this.createdAt,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'patient_id': patientId,
      'appointment_date': appointmentDate,
      'appointment_time': appointmentTime,
      'status': status,
      'created_at': createdAt,
    };
  }
}
