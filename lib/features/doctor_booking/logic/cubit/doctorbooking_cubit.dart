import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/auth/logic/cubit/patients_cubit.dart';
import 'package:heal_care/features/doctor_booking/data/models/doctor_booking_model.dart';
import 'package:heal_care/features/doctor_booking/data/repos/doctor_booking_repositories.dart';


part 'doctorbooking_state.dart';

class DoctorbookingCubit extends Cubit<DoctorbookingState> {
  DoctorbookingCubit(this.doctorBookingRepositories, this.doctorsCubit, this.patientsCubit) : super(DoctorbookingInitial());
  final DoctorBookingRepositories doctorBookingRepositories;
  List<DoctorBookingModel> doctorBooking = [];
    final DoctorsCubit doctorsCubit;
    final PatientsCubit patientsCubit;

 
  Future<void> fetchAppointments() async {
    emit(DoctorbookingLoading());
 
    final dId = CacheHelper().getData(key: 'doctor_Id');

    if (dId == null || dId.toString().isEmpty) {
      emit(DoctorbookingFailure( "Missing patient ID"));
      return;
    }

    final url = "${AppConstants.baseRestUrl}appointments?doctor_id=eq.$dId";

    final result = await doctorBookingRepositories.getDoctorBooking(
      url,
    );

    result.fold(
      (error) => emit(DoctorbookingFailure( error)),
      (data) {
        for (var appointment in data) {
          final patient = patientsCubit.patientsModel.firstWhere(
            (patient) => patient.id == appointment.patientId,
            orElse: () => PatientsModel(name: "Patient Not Found"),
          );
          appointment.patient = patient;
        }

        doctorBooking = data;
        emit(DoctorbookingSuccess( doctorBooking));
      },
    );
  }
}
