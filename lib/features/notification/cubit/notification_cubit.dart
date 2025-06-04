import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/notification/data/model/notification_model.dart';
import 'package:heal_care/features/notification/data/repos/notification_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.notificationRepository, this.doctorsCubit)
      : super(NotificationInitial());

  final NotificationRepository notificationRepository;
  Future<void> fetchNotifications(String path, dynamic doctorId) async {
    emit(NotificationLoading());
    final data = {
      "doc_id": doctorId,
    };

    final result = await notificationRepository.getNotifications(path, data);
    result.fold(
      (error) => emit(NotificationError(error)),
      (notifications) => emit(NotificationSuccess(notifications)),
    );
  }

  final DoctorsCubit doctorsCubit;

  Future<void> seenNotification(String path, dynamic doctorId) async {
    emit(NotificationSeenLoading());
    final data = {
      "doc_id": doctorId,
    };
    final result =
        await notificationRepository.seenNotification(path: path, data: data);
    result.fold(
      (error) => emit(NotificationSeenError(error)),
      (_) => emit(NotificationSeenSuccess()),
    );
  }
}
