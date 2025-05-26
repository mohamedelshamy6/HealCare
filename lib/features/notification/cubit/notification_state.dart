part of 'notification_cubit.dart';

sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationLoading extends NotificationState {}

final class NotificationSuccess extends NotificationState {
  final List<NotificationModel> notifications;

  NotificationSuccess(this.notifications);
}

final class NotificationError extends NotificationState {
  final String error;

  NotificationError(this.error);
}

final class NotificationSeenSuccess extends NotificationState {}

final class NotificationSeenError extends NotificationState {
  final String error;

  NotificationSeenError(this.error);
}

final class NotificationSeenLoading extends NotificationState {}
