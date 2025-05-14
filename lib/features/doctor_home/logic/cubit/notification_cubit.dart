import 'package:bloc/bloc.dart';
import 'package:heal_care/features/doctor_home/data/models/notification_model.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
}
