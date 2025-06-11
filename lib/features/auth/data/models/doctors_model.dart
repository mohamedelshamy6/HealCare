class DoctorsModel {
  String? id;
  String? name;
  String? email;
  String? image;
  String? specialization;
  String? bio;
  String? address;
  String? experience;
  String? education;
  String? gender;
  String? instapayLink;
  String? createdAt;
  bool? isFavourite;

  DoctorsModel({
    this.id,
    this.name,
    this.email,
    this.image,
    this.specialization,
    this.bio,
    this.address,
    this.experience,
    this.education,
    this.gender,
    this.instapayLink,
    this.createdAt,
    this.isFavourite,
  });

  DoctorsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        image = json['image'],
        specialization = json['specialization'],
        bio = json['bio'],
        address = json['address'],
        experience = json['experience']?.toString(),
        education = json['education']?.toString(),
        gender = json['gender'],
        instapayLink = json['insta_pay_link'],
        createdAt = json['created_at'],
        isFavourite = json['isFavourite'] ?? false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['specialization'] = specialization;
    data['bio'] = bio;
    data['address'] = address;
    data['experience'] = experience;
    data['education'] = education;
    data['gender'] = gender;
    data['insta_pay_link'] = instapayLink;
    data['created_at'] = createdAt;
    data['isFavourite'] = isFavourite;
    return data;
  }

  DoctorsModel copyWith({
    String? id,
    String? name,
    String? email,
    String? image,
    String? specialization,
    String? bio,
    String? address,
    String? experience,
    String? education,
    String? gender,
    String? instapayLink,
    String? createdAt,
    bool? isFavourite,
  }) {
    return DoctorsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      specialization: specialization ?? this.specialization,
      bio: bio ?? this.bio,
      address: address ?? this.address,
      experience: experience ?? this.experience,
      education: education ?? this.education,
      gender: gender ?? this.gender,
      instapayLink: instapayLink ?? this.instapayLink,
      createdAt: createdAt ?? this.createdAt,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
