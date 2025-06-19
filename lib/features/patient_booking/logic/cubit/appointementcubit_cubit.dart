import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/core/helpers/user_cache_helper.dart';
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

    try {
      // First ensure doctors are loaded and wait for the state to update
      if (doctorsCubit.state is! DoctorsSuccess ||
          (doctorsCubit.state is DoctorsSuccess &&
              (doctorsCubit.state as DoctorsSuccess).doctorsModel.isEmpty)) {
        await doctorsCubit.getAllDoctors();

        // Wait for the state to update with doctors data
        await for (final state in doctorsCubit.stream) {
          if (state is DoctorsSuccess) {
            if (state.doctorsModel.isNotEmpty) {
              break;
            }
          } else if (state is DoctorsFailure) {
            log('Failed to load doctors: ${state.error}');
            break;
          }
        }
      }

      final patientData = await UserCacheHelper.getCachedPatientData();
      final pId = CacheHelper().getData(key: 'patient_Id') ??
          CacheHelper().getData(key: 'userId') ??
          patientData?.id;
      log('Patient ID: $pId');

      if (pId == null || pId.toString().isEmpty) {
        emit(AppointementcubitFailure(error: "Missing patient ID"));
        return;
      }

      final url = "${AppConstants.baseRestUrl}appointments?patient_id=eq.$pId";
      final result = await appointmentRepositories.getAppointments(url);

      result.fold(
        (error) => emit(AppointementcubitFailure(error: error)),
        (data) {
          final updatedAppointments = <AppointmentModel>[];
          final doctors = (doctorsCubit.state is DoctorsSuccess)
              ? (doctorsCubit.state as DoctorsSuccess).doctorsModel
              : <DoctorsModel>[];

          log('Found ${doctors.length} doctors in the system');
          log('Processing ${data.length} appointments');

          for (var appointment in data) {
            try {
              log('Processing appointment with doctorId: ${appointment.doctorId}');

              // Log all doctor IDs for debugging
              log('Available doctor IDs: ${doctors.map((d) => d.id).toList()}');

              final doctor = doctors.firstWhere(
                (doc) {
                  final match = doc.id == appointment.doctorId;
                  log('Checking doctor ${doc.id} == ${appointment.doctorId}: $match');
                  return match;
                },
                orElse: () {
                  log('Doctor with ID ${appointment.doctorId} not found in doctors list');
                  return DoctorsModel(
                    id: appointment.doctorId,
                    name: "Doctor not found (ID: ${appointment.doctorId})",
                  );
                },
              );

              log('Found doctor for appointment: ${doctor.name} (ID: ${doctor.id})');
              updatedAppointments.add(appointment.copyWith(doctor: doctor));
            } catch (e) {
              log('Error processing appointment ${appointment.id}: $e');
              updatedAppointments.add(appointment.copyWith(
                doctor: DoctorsModel(
                  id: appointment.doctorId,
                  name: "Error loading doctor (ID: ${appointment.doctorId})",
                ),
              ));
            }
          }

          appointments = updatedAppointments;
          emit(AppointementcubitSuccess(appointments: appointments));
        },
      );
    } catch (e) {
      log('Error in fetchAppointments: $e');
      emit(AppointementcubitFailure(error: "Failed to load appointments: $e"));
    }
  }
}
