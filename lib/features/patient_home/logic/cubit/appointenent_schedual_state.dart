part of 'appointenent_schedual_cubit.dart';


sealed class AppointenentSchedualState {}

final class AppointenentSchedualInitial extends AppointenentSchedualState {}

final class AppointenentSchedualLoading extends AppointenentSchedualState {}

final class AppointenentSchedualSuccess extends AppointenentSchedualState {
  final List<AppointementScheduleModel> appointenentSchedual;
  AppointenentSchedualSuccess(this.appointenentSchedual);
}

final class AppointenentSchedualError extends AppointenentSchedualState {
  final String error;
  AppointenentSchedualError(this.error);
}
