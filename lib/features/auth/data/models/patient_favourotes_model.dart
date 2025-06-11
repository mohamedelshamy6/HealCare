class PatientFavouritesModel {
  String? doctorId;
  String? doctorName;
  String? doctorImage;
  String? specialization;
  double? averageRate;

  PatientFavouritesModel(
      {this.doctorId,
      this.doctorName,
      this.doctorImage,
      this.specialization,
      this.averageRate});

  PatientFavouritesModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name'];
    doctorImage = json['doctor_image'];
    specialization = json['specialization'];
    averageRate = (json['average_rate'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctor_id'] = doctorId;
    data['doctor_name'] = doctorName;
    data['doctor_image'] = doctorImage;
    data['specialization'] = specialization;
    data['average_rate'] = averageRate;
    return data;
  }
}
