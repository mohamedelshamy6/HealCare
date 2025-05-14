import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/features/doctor_home/data/models/notification_model.dart';
import 'package:heal_care/features/doctor_home/data/repos/notification_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.notificationRepository) : super(NotificationInitial());

  final NotificationRepository notificationRepository;
  Future<void> fetchNotifications(String path,dynamic doctorId) async {
    emit(NotificationLoading());
    final data = {
      "doctor_id": doctorId,
    };
    
    final result = await notificationRepository.getNotifications(path, data);
    result.fold(
      (error) => emit(NotificationError(error)),
      (notifications) => emit(NotificationSuccess(notifications)),
    );
  }
}
