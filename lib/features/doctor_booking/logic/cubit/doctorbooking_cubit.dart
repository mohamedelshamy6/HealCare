import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';
import 'package:heal_care/features/auth/data/repos/patients_repo.dart';
import 'package:heal_care/features/auth/logic/cubit/patients_cubit.dart';
import 'package:heal_care/features/doctor_booking/data/models/doctor_booking_model.dart';
import 'package:heal_care/features/doctor_booking/data/repos/doctor_booking_repositories.dart';

part 'doctorbooking_state.dart';

class DoctorbookingCubit extends Cubit<DoctorbookingState> {
  DoctorbookingCubit(
      this.doctorBookingRepositories, this.patientsCubit, this.patientsRepo)
      : super(DoctorbookingInitial());
  final DoctorBookingRepositories doctorBookingRepositories;
  List<DoctorBookingModel> doctorBooking = [];
  final PatientsCubit patientsCubit;
  final PatientsRepo patientsRepo;

  Future<void> fetchAppointments(String doctorId) async {
    emit(DoctorbookingLoading());

    if (doctorId.isEmpty) {
      emit(DoctorbookingFailure("Missing doctor ID"));
      return;
    }

    final patientsList = patientsCubit.patientsModel;

    final url =
        "${AppConstants.baseRestUrl}appointments?doctor_id=eq.$doctorId";

    final result = await doctorBookingRepositories.getDoctorBooking(url);

    result.fold(
      (error) => emit(DoctorbookingFailure(error)),
      (data) {
        for (var appointment in data) {
          final patient = patientsList.firstWhere(
            (p) => p.id == appointment.patientId,
            orElse: () => PatientsModel(name: "Patient Not Found"),
          );
          appointment.patient = patient;
        }

        doctorBooking = data;
        emit(DoctorbookingSuccess(doctorBooking));
      },
    );
  }
}
