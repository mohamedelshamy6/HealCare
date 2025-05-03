class LoginModel {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  int? expiresAt;
  String? refreshToken;
  User? user;

  LoginModel(
      {this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.expiresAt,
      this.refreshToken,
      this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    expiresAt = json['expires_at'];
    refreshToken = json['refresh_token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  String? id;
  String? aud;
  String? role;
  String? email;
  String? emailConfirmedAt;
  String? phone;
  String? confirmedAt;
  String? lastSignInAt;
  AppMetadata? appMetadata;
  UserMetaData? userMetadata;
  List<Identities>? identities;
  String? createdAt;
  String? updatedAt;
  bool? isAnonymous;

  User(
      {this.id,
      this.aud,
      this.role,
      this.email,
      this.emailConfirmedAt,
      this.phone,
      this.confirmedAt,
      this.lastSignInAt,
      this.appMetadata,
      this.userMetadata,
      this.identities,
      this.createdAt,
      this.updatedAt,
      this.isAnonymous});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aud = json['aud'];
    role = json['role'];
    email = json['email'];
    emailConfirmedAt = json['email_confirmed_at'];
    phone = json['phone'];
    confirmedAt = json['confirmed_at'];
    lastSignInAt = json['last_sign_in_at'];
    appMetadata = json['app_metadata'] != null
        ? AppMetadata.fromJson(json['app_metadata'])
        : null;
    userMetadata = json['user_metadata'] != null
        ? UserMetaData.fromJson(json['user_metadata'])
        : null;
    if (json['identities'] != null) {
      identities = <Identities>[];
      json['identities'].forEach((v) {
        identities!.add(Identities.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isAnonymous = json['is_anonymous'];
  }
}

class AppMetadata {
  String? provider;
  List<String>? providers;

  AppMetadata({this.provider, this.providers});

  AppMetadata.fromJson(Map<String, dynamic> json) {
    provider = json['provider'];
    providers = json['providers'].cast<String>();
  }
}

class UserMetaData {
  String? address;
  int? age;
  String? bio;
  String? bloodType;
  String? disease;
  String? education;
  String? email;
  bool? emailVerified;
  String? experience;
  String? gender;
  int? height;
  String? image;
  String? instaPayLink;
  String? medicalHistory;
  String? name;
  bool? phoneVerified;
  String? specialization;
  String? sub;
  String? type;
  int? weight;

  UserMetaData(
      {this.address,
      this.age,
      this.bio,
      this.bloodType,
      this.disease,
      this.education,
      this.email,
      this.emailVerified,
      this.experience,
      this.gender,
      this.height,
      this.image,
      this.instaPayLink,
      this.medicalHistory,
      this.name,
      this.phoneVerified,
      this.specialization,
      this.sub,
      this.type,
      this.weight});

  UserMetaData.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    age = json['age'];
    bio = json['bio'];
    bloodType = json['blood_type'];
    disease = json['disease'];
    education = json['education'];
    email = json['email'];
    emailVerified = json['email_verified'];
    experience = json['experience'];
    gender = json['gender'];
    height = json['height'];
    image = json['image'];
    instaPayLink = json['insta_pay_link'];
    medicalHistory = json['medical_history'];
    name = json['name'];
    phoneVerified = json['phone_verified'];
    specialization = json['specialization'];
    sub = json['sub'];
    type = json['type'];
    weight = json['weight'];
  }
}

class Identities {
  String? identityId;
  String? id;
  String? userId;
  UserMetaData? identityData;
  String? provider;
  String? lastSignInAt;
  String? createdAt;
  String? updatedAt;
  String? email;

  Identities(
      {this.identityId,
      this.id,
      this.userId,
      this.identityData,
      this.provider,
      this.lastSignInAt,
      this.createdAt,
      this.updatedAt,
      this.email});

  Identities.fromJson(Map<String, dynamic> json) {
    identityId = json['identity_id'];
    id = json['id'];
    userId = json['user_id'];
    identityData = json['identity_data'] != null
        ? UserMetaData.fromJson(json['identity_data'])
        : null;
    provider = json['provider'];
    lastSignInAt = json['last_sign_in_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    email = json['email'];
  }
}
