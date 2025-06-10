import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/features/notification/data/model/notification_model.dart';
import 'package:heal_care/features/notification/data/repos/notification_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.notificationRepository)
      : super(NotificationInitial());

  final NotificationRepository notificationRepository;
  Future<void> fetchNotificationsforDoctors(
      String path, dynamic doctorId) async {
    emit(NotificationDoctorLoading());
    final data = {
      "user_id": doctorId,
    };

    final result =
        await notificationRepository.getNotificationsforDoctors(path, data);
    result.fold(
      (error) => emit(NotificationDoctorError(error)),
      (notifications) => emit(NotificationDoctorSuccess(notifications)),
    );
  }

  Future<void> fetchNotificationsforPatient(
      String path, dynamic patientId) async {
    emit(NotificationPatientLoading());
    final data = {
      "user_id": patientId,
    };

    final result =
        await notificationRepository.getNotificationsforPatients(path, data);
    result.fold(
      (error) => emit(NotificationPatientError(error)),
      (notifications) => emit(NotificationPatientSuccess(notifications)),
    );
  }

  

  Future<void> seenNotification(String path, dynamic id) async {
    emit(NotificationSeenLoading());
    final data = {
      "user_id": id,
    };
    final result =
        await notificationRepository.seenNotification(path: path, data: data);
    result.fold(
      (error) => emit(NotificationSeenError(error)),
      (_) => emit(NotificationSeenSuccess()),
    );
  }
}
