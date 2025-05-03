class PatientsModel {
  String? id;
  String? name;
  String? email;
  String? image;
  String? createdAt;
  String? gender;
  String? address;
  int? age;
  String? bloodType;
  int? height;
  int? weight;
  String? disease;
  String? medicalHistory;

  PatientsModel({
    this.id,
    this.name,
    this.email,
    this.image,
    this.createdAt,
    this.gender,
    this.address,
    this.age,
    this.bloodType,
    this.height,
    this.weight,
    this.disease,
    this.medicalHistory,
  });

  PatientsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    createdAt = json['created_at'];
    gender = json['gender'];
    address = json['address'];
    age = json['age'];
    bloodType = json['blood_type'];
    height = json['height'];
    weight = json['weight'];
    disease = json['disease'];
    medicalHistory = json['medical_history'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['gender'] = gender;
    data['address'] = address;
    data['age'] = age;
    data['blood_type'] = bloodType;
    data['height'] = height;
    data['weight'] = weight;
    data['disease'] = disease;
    data['medical_history'] = medicalHistory;
    return data;
  }
}
