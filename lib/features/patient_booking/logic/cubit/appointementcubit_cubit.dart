import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/auth/logic/cubit/patients_cubit.dart';
import 'package:heal_care/features/patient_booking/data/model/appoientment_model.dart';
import 'package:heal_care/features/patient_booking/data/repos/appointment_repositories.dart';

part 'appointementcubit_state.dart';

class AppointementcubitCubit extends Cubit<AppointementcubitState> {
  AppointementcubitCubit(
      this.appointmentRepositories, this.doctorsCubit, this.patientsCubit)
      : super(AppointementcubitInitial());
  final AppointmentRepositories appointmentRepositories;
  final DoctorsCubit doctorsCubit;
  final PatientsCubit patientsCubit;
  List<AppointmentModel> appointments = [];
  String patientId = '';
  Future<void> fetchAppointments() async {
    emit(AppointementcubitLoading());

    final pId = CacheHelper().getData(key: 'patient_Id')??
        CacheHelper().getData(key: 'userId');

    if (pId == null || pId.toString().isEmpty) {
      emit(AppointementcubitFailure(error: "Missing patient ID"));
      return;
    }

    final url = "${AppConstants.baseRestUrl}appointments?patient_id=eq.$pId";

    final result = await appointmentRepositories.getAppointments(
      url,
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