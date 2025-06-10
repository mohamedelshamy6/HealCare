part of 'notification_cubit.dart';

sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationDoctorLoading extends NotificationState {}

final class NotificationDoctorSuccess extends NotificationState {
  final List<NotificationModel> notifications;

  NotificationDoctorSuccess(this.notifications);
}

final class NotificationDoctorError extends NotificationState {
  final String error;

  NotificationDoctorError(this.error);
}

final class NotificationPatientLoading extends NotificationState {}
final class NotificationPatientSuccess extends NotificationState {
  final List<NotificationModel> notifications;

  NotificationPatientSuccess(this.notifications);
}
final class NotificationPatientError extends NotificationState {
  final String error;

  NotificationPatientError(this.error);
}

final class NotificationSeenSuccess extends NotificationState {}

final class NotificationSeenError extends NotificationState {
  final String error;

  NotificationSeenError(this.error);
}

final class NotificationSeenLoading extends NotificationState {}
