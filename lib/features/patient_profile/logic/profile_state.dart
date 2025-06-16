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


