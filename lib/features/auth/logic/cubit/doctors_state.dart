part of 'doctors_cubit.dart';

sealed class DoctorsState {}

final class DoctorsInitial extends DoctorsState {}

final class DoctorsLoading extends DoctorsState {}

final class DoctorsSuccess extends DoctorsState {
  final List<DoctorsModel> doctorsModel;

  DoctorsSuccess({required this.doctorsModel});
}

final class DoctorsFailure extends DoctorsState {
  final String error;

  DoctorsFailure({required this.error});
}

final class PatientFavouritesSuccess extends DoctorsState {
  final List<PatientFavouritesModel> patientFavoritesModel;

  PatientFavouritesSuccess({required this.patientFavoritesModel});
}

final class PatientFavouritesFailure extends DoctorsState {
  final String error;

  PatientFavouritesFailure({required this.error});
}

final class PatientFavouritesLoading extends DoctorsState {}
