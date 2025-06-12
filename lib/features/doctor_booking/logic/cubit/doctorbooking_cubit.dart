import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';
import 'package:heal_care/features/auth/data/repos/patients_repo.dart';
import 'package:heal_care/features/auth/logic/cubit/patients_cubit.dart';
import 'package:heal_care/features/doctor_booking/data/models/doctor_booking_model.dart';
import 'package:heal_care/features/doctor_booking/data/repos/cancel_appointment_model.dart';
import 'package:heal_care/features/doctor_booking/data/repos/doctor_booking_repositories.dart';

part 'doctorbooking_state.dart';

class DoctorbookingCubit extends Cubit<DoctorbookingState> {
  DoctorbookingCubit(this.doctorBookingRepositories, this.patientsCubit,
      this.patientsRepo, this.cancelAppointmentRepo)
      : super(DoctorbookingInitial());
      
  final DoctorBookingRepositories doctorBookingRepositories;
  List<DoctorBookingModel> doctorBooking = [];
  final PatientsCubit patientsCubit;
  final PatientsRepo patientsRepo;
  final CancelAppointmentRepo cancelAppointmentRepo;
  
  // Store current doctor ID for refreshing
  String? _currentDoctorId;

  Future<void> fetchAppointments(String doctorId) async {
    emit(DoctorbookingLoading());

    if (doctorId.isEmpty) {
      emit(DoctorbookingFailure("Missing doctor ID"));
      return;
    }

    // Store the current doctor ID
    _currentDoctorId = doctorId;

    final patientsList = patientsCubit.patientsModel;

    final url =
        "${AppConstants.baseRestUrl}appointments?doctor_id=eq.$doctorId";

    final result = await doctorBookingRepositories.getDoctorBooking(url);

    result.fold(
      (error) {
        emit(DoctorbookingFailure(error));
      },
      (data) {
        for (var appointment in data) {
          final patient = patientsList.firstWhere(
            (p) => p.id == appointment.patientId,
            orElse: () {
              return PatientsModel(name: "Patient Not Found");
            },
          );
          appointment.patient = patient;
        }

        doctorBooking = data;
        emit(DoctorbookingSuccess(doctorBooking));
      },
    );
  }

  Future<void> cancelAppointment(String appointmentId) async {
    emit(DoctorbookingCancelAppointmentLoading());

    final url = "${AppConstants.baseRestUrl}rpc/cancel_appointment";

    final result = await cancelAppointmentRepo.cancelAppointment(url, {
      'appointment_id': appointmentId,
    });

    result.fold(
      (error) => emit(DoctorbookingCancelAppointmentFailure(message: error)),
      (data) {
        // Emit success message first
        emit(DoctorbookingCancelAppointmentSuccess(message: "Appointment cancelled successfully"));
        
        // Then refresh the appointments list
        if (_currentDoctorId != null && _currentDoctorId!.isNotEmpty) {
          _refreshAppointments();
        }
      },
    );
  }

  // Private method to refresh appointments after cancellation
  Future<void> _refreshAppointments() async {
    if (_currentDoctorId == null) return;

    final patientsList = patientsCubit.patientsModel;
    final url = "${AppConstants.baseRestUrl}appointments?doctor_id=eq.$_currentDoctorId";

    final result = await doctorBookingRepositories.getDoctorBooking(url);

    result.fold(
      (error) => emit(DoctorbookingFailure(error)),
      (data) {
        for (var appointment in data) {
          final patient = patientsList.firstWhere(
            (p) => p.id == appointment.patientId,
            orElse: () {
              return PatientsModel(name: "Patient Not Found");
            },
          );
          appointment.patient = patient;
        }

        doctorBooking = data;
        emit(DoctorbookingSuccess(doctorBooking));
      },
    );
  }

  // Optional: Method to cancel all appointments
  Future<void> cancelAllAppointments(List<String> appointmentIds) async {
    emit(DoctorbookingCancelAppointmentLoading());

    try {
      final url = "${AppConstants.baseRestUrl}rpc/cancel_appointment";
      
      // Cancel all appointments
      for (String appointmentId in appointmentIds) {
        final result = await cancelAppointmentRepo.cancelAppointment(url, {
          'appointment_id': appointmentId,
        });
        
        result.fold(
          (error) => throw Exception(error),
          (data) => null, // Continue with next appointment
        );
      }

      // Emit success message
      emit(DoctorbookingCancelAppointmentSuccess(message: "All appointments cancelled successfully"));
      
      // Refresh the appointments list
      if (_currentDoctorId != null && _currentDoctorId!.isNotEmpty) {
        _refreshAppointments();
      }
    } catch (e) {
      emit(DoctorbookingCancelAppointmentFailure(message: e.toString()));
    }
  }
}