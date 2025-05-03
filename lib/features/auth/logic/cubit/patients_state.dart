part of 'patients_cubit.dart';

@immutable
sealed class PatientsState {}

final class PatientsInitial extends PatientsState {}

final class PatientsLoading extends PatientsState {}

final class PatientsSuccess extends PatientsState {
  final List<PatientsModel> patientsModel;

  PatientsSuccess({required this.patientsModel});
}

final class PatientsFailure extends PatientsState {
  final String error;

  PatientsFailure({required this.error});
}
