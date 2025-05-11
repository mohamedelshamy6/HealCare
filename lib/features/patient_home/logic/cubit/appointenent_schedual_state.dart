part of 'appointenent_schedual_cubit.dart';

sealed class AppointenentSchedualState {}

final class AppointenentSchedualInitial extends AppointenentSchedualState {}

final class AppointmentScheduleLoading extends AppointenentSchedualState {}

final class AppointenentSchedualSuccess extends AppointenentSchedualState {
  final AppointementScheduleModel schedule;

  AppointenentSchedualSuccess(this.schedule);
}

final class AppointenentSchedualError extends AppointenentSchedualState {
  final String error;
  AppointenentSchedualError(this.error);
}

final class AppointmentBookingLoading extends AppointenentSchedualState {}

final class AppointmentBookingSuccess extends AppointenentSchedualState {}

final class AppointmentBookingError extends AppointenentSchedualState {
  final String error;
  AppointmentBookingError(this.error);
}
