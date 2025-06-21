part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccessForDoctors extends ProfileState {
  final DoctorsModel? doctor;

  ProfileSuccessForDoctors({this.doctor});
}

class ProfileErrorForDoctors extends ProfileState {
  final String error;

  ProfileErrorForDoctors({ required this.error});
}

class ProfileLoadingForPatients extends ProfileState {}

class ProfileLoadingForDoctors extends ProfileState {}

class ProfileSuccessForPatients extends ProfileState {
  final PatientsModel? patient;

  ProfileSuccessForPatients({this.patient});
}

class ProfileErrorForPatients extends ProfileState {
  final String error;

  ProfileErrorForPatients({ required this.error});
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError({ required this.error});
}

class UpdateProfileLoadingForPatients extends ProfileState {}

class UpdateProfileSuccessForPatients extends ProfileState {
  final PatientsModel? patient;

  UpdateProfileSuccessForPatients({this.patient});
}

class UpdateProfileErrorForPatients extends ProfileState {
  final String error;

  UpdateProfileErrorForPatients({ required this.error});
}

class UpdateProfileLoadingForDoctors extends ProfileState {}

class UpdateProfileSuccessForDoctors extends ProfileState {
  final DoctorsModel? doctor;

  UpdateProfileSuccessForDoctors({this.doctor});
}

class UpdateProfileErrorForDoctors extends ProfileState {
  final String error;

  UpdateProfileErrorForDoctors({ required this.error});
}





