class SignUpModel {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  int? expiresAt;
  String? refreshToken;
  User? user;

  SignUpModel(
      {this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.expiresAt,
      this.refreshToken,
      this.user});

  SignUpModel.fromJson(Map<String, dynamic> json) {
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
  String? lastSignInAt;
  AppMetadata? appMetadata;
  UserMetadata? userMetadata;
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
    lastSignInAt = json['last_sign_in_at'];
    appMetadata = json['app_metadata'] != null
        ? AppMetadata.fromJson(json['app_metadata'])
        : null;
    userMetadata = json['user_metadata'] != null
        ? UserMetadata.fromJson(json['user_metadata'])
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

class UserMetadata {
  String? email;
  bool? emailVerified;
  bool? phoneVerified;
  String? sub;

  UserMetadata({this.email, this.emailVerified, this.phoneVerified, this.sub});

  UserMetadata.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    emailVerified = json['email_verified'];
    phoneVerified = json['phone_verified'];
    sub = json['sub'];
  }
}

class Identities {
  String? identityId;
  String? id;
  String? userId;
  UserMetadata? identityData;
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
        ? UserMetadata.fromJson(json['identity_data'])
        : null;
    provider = json['provider'];
    lastSignInAt = json['last_sign_in_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    email = json['email'];
  }
}
