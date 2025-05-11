
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
