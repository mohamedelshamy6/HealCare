import 'package:bloc/bloc.dart';
import 'package:heal_care/features/doctor_booking/data/models/doctor_booking_model.dart';
import 'package:meta/meta.dart';

part 'doctorbooking_state.dart';

class DoctorbookingCubit extends Cubit<DoctorbookingState> {
  DoctorbookingCubit() : super(DoctorbookingInitial());
}
