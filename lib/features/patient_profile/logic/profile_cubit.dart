import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/core/helpers/user_cache_helper.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';
import 'package:heal_care/features/auth/data/repos/doctors_repo.dart';
import 'package:heal_care/features/auth/data/repos/patients_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final DoctorsRepo doctorsRepo;
  final PatientsRepo patientsRepo;

  ProfileCubit(
    this.doctorsRepo,
    this.patientsRepo,
  ) : super(ProfileInitial());

  Future<void> getProfileDataForPatients() async {
    try {
      emit(ProfileLoadingForPatients());

      // First try to get patient data from cache
      final cachedPatient = await UserCacheHelper.getCachedPatientData();
      if (cachedPatient != null && cachedPatient.id != null) {
        emit(ProfileSuccessForPatients(patient: cachedPatient));
        return;
      }

      final String? userId = CacheHelper().getData(key: 'userId');
      if (userId == null) {
        emit(ProfileErrorForPatients(error: 'User not logged in'));
        return;
      }

      final response = await patientsRepo
          .getAllPatients("${AppConstants.baseRestUrl}patients");

      response.fold(
        (error) => emit(ProfileErrorForPatients(error: error.toString())),
        (patients) {
          if (patients.isNotEmpty) {
            final patient =
                patients.firstWhere((patient) => patient.id == userId);

            // Cache the patient data for future use
            UserCacheHelper.cachePatientData(patient);
            emit(ProfileSuccessForPatients(patient: patient));
          } else {
            emit(ProfileErrorForPatients(error: 'No patient data found'));
          }
        },
      );
    } catch (e) {
      emit(ProfileErrorForPatients(
          error: 'Failed to fetch patient data: ${e.toString()}'));
    }
  }

  Future<void> getProfileDataForDoctors() async {
    try {
      emit(ProfileLoadingForDoctors());

      // First try to get doctor data from cache
      final cachedDoctors = await UserCacheHelper.getCachedDoctorData();
      if (cachedDoctors != null && cachedDoctors.id != null) {
        emit(ProfileSuccessForDoctors(doctor: cachedDoctors));
        return;
      }

      final String? userId = CacheHelper().getData(key: 'doctor_Id') ??
          CacheHelper().getData(key: 'userId');
      if (userId == null) {
        emit(ProfileErrorForDoctors(error: 'User not logged in'));
        return;
      }

      final response =
          await doctorsRepo.getAllDoctors("${AppConstants.baseRestUrl}doctors");

      response.fold(
        (error) => emit(ProfileErrorForDoctors(error: error.toString())),
        (doctors) {
          if (doctors.isNotEmpty) {
            final doctor = doctors.firstWhere((doctor) => doctor.id == userId);

            // Cache the doctor data for future use
            UserCacheHelper.cacheDoctorData(doctor);
            log(UserCacheHelper.getCachedDoctorData().toString());
            emit(ProfileSuccessForDoctors(doctor: doctor));
          } else {
            emit(ProfileErrorForDoctors(error: 'No doctor data found'));
          }
        },
      );
    } catch (e) {
      emit(ProfileErrorForDoctors(
          error: 'Failed to fetch doctor data: ${e.toString()}'));
    }
  }

  
}
