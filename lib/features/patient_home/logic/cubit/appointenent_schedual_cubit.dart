import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/features/patient_home/data/models/appointement_schedual_model.dart';
import 'package:heal_care/features/patient_home/data/repos/appointenent_schedual_repositorie.dart';
import 'package:heal_care/features/patient_home/data/repos/book_appointment_repository.dart';
part 'appointenent_schedual_state.dart';

class AppointenentSchedualCubit extends Cubit<AppointenentSchedualState> {
  AppointenentSchedualCubit(
    this.appointenentSchedualRepositorie,
    this.bookAppointmentRepository,
  ) : super(AppointenentSchedualInitial());

  final AppointenentSchedualRepositorie appointenentSchedualRepositorie;
  final BookAppointmentRepository bookAppointmentRepository;
  AppointementScheduleModel? _schedule;
  String? _selectedDay;

  Future<void> fetchSchedule(String path, String doctorId) async {
    emit(AppointmentScheduleLoading());

    final result = await appointenentSchedualRepositorie
        .getAppointementSchedule(path, doctorId);

    result.fold(
      (error) => emit(AppointenentSchedualError(error)),
      (data) {
        _schedule = data;
        _selectedDay = data.days.keys.first;
        emit(AppointenentSchedualSuccess(data));
      },
    );
  }

  void selectDay(String selectedDay) {
    _selectedDay = selectedDay;
    if (_schedule != null) {
      emit(AppointenentSchedualSuccess(_schedule!));
    }
  }

  List<TimeSlot> get selectedDaySlots {
    if (_selectedDay != null && _schedule != null) {
      return _schedule!.days[_selectedDay!] ?? [];
    }
    return [];
  }

  String? get selectedDay => _selectedDay;

  Future<void> bookAppointment({
    required dynamic data,
    required String path,
  }) async {
    emit(AppointmentBookingLoading());

    final result = await bookAppointmentRepository.createAppointment(
        path: path, body: data);

    result.fold(
      (error) => emit(AppointmentBookingError(error)),
      (_) => emit(AppointmentBookingSuccess()),
    );
  }
}
