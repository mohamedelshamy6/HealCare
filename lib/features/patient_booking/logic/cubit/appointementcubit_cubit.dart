import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/patient_booking/data/appoientment_model.dart';
import 'package:heal_care/features/patient_booking/data/repos/appointment_repositories.dart';

part 'appointementcubit_state.dart';

class AppointementcubitCubit extends Cubit<AppointementcubitState> {
  AppointementcubitCubit(this.appointmentRepositories, this.doctorsCubit) : super(AppointementcubitInitial());
  final AppointmentRepositories appointmentRepositories;
  final DoctorsCubit doctorsCubit;
   List<AppointmentModel> appointments = [];

  Future<void> fetchAppointments(String patientId) async {
    emit(AppointementcubitLoading());

    final result = await appointmentRepositories.getAppointments(
      patientId,
      "${AppConstants.baseRestUrl}appointments", 
    );

    result.fold(
      (error) => emit(AppointementcubitFailure(error: error)),
      (data) {
        for (var appointment in data) {
          final doctor = doctorsCubit.doctorsModel.firstWhere(
            (doc) => doc.id == appointment.doctorId,
            orElse: () => DoctorsModel(name: "Doctor Not Found"),
          );
          appointment.doctor = doctor;
        }

        appointments = data;
        emit(AppointementcubitSuccess(appointments: appointments));
      },
    );
  }
}
