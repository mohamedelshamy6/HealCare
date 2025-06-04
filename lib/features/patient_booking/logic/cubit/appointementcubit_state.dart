part of 'appointementcubit_cubit.dart';


sealed class AppointementcubitState {}

final class AppointementcubitInitial extends AppointementcubitState {}

final class AppointementcubitLoading extends AppointementcubitState {}

final class AppointementcubitSuccess extends AppointementcubitState {
  final List<AppointmentModel> appointments;
  AppointementcubitSuccess({required this.appointments});
}

final class AppointementcubitFailure extends AppointementcubitState {
  final String error;
  AppointementcubitFailure({required this.error});
}