import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/core/helpers/user_cache_helper.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';
import 'package:heal_care/features/auth/data/repos/doctors_repo.dart';
import 'package:heal_care/features/auth/data/repos/patients_repo.dart';
import 'package:heal_care/features/patient_home/data/models/appointement_schedual_model.dart';
import 'package:heal_care/features/patient_home/data/repos/appointenent_schedual_repositorie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final DoctorsRepo doctorsRepo;
  final PatientsRepo patientsRepo;
  final AppointenentSchedualRepositorie appointenentSchedualRepositorie;

  ProfileCubit(
    this.doctorsRepo,
    this.patientsRepo,
    this.appointenentSchedualRepositorie,
  ) : super(ProfileInitial());

  Future<void> getProfileDataForPatients({bool forceRefresh = false}) async {
    try {
      emit(ProfileLoadingForPatients());

      if (!forceRefresh) {
        final cachedPatient = await UserCacheHelper.getCachedPatientData();
        if (cachedPatient != null && cachedPatient.id != null) {
          final cacheTime = CacheHelper().getData(key: 'patient_cache_time');
          final now = DateTime.now().millisecondsSinceEpoch;
          if (cacheTime != null && (now - (cacheTime as int)) < 3600000) {
            emit(ProfileSuccessForPatients(patient: cachedPatient));
            return;
          }
        }
      }

      final String? userId = CacheHelper().getData(key: 'userId');
      if (userId == null) {
        emit(ProfileErrorForPatients(error: 'User not logged in'));
        return;
      }

      final response = await patientsRepo
          .getAllPatients("${AppConstants.baseRestUrl}patients");
      response.fold(
        (error) => emit(ProfileErrorForPatients(error: error)),
        (patients) {
          if (patients.isNotEmpty) {
            final patient = patients.firstWhere(
              (patient) => patient.id == userId,
              orElse: () => throw Exception('Patient not found'),
            );
            // Cache the patient data and update cache time
            UserCacheHelper.cachePatientData(patient);
            CacheHelper().saveData(
              key: 'patient_cache_time',
              value: DateTime.now().millisecondsSinceEpoch,
            );
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

  Future<void> getProfileDataForDoctors({bool forceRefresh = false}) async {
    try {
      emit(ProfileLoadingForDoctors());

      // Only check cache if we're not forcing a refresh
      if (!forceRefresh) {
        final cachedDoctor = await UserCacheHelper.getCachedDoctorData();
        if (cachedDoctor != null && cachedDoctor.id != null) {
          final cacheTime = CacheHelper().getData(key: 'doctor_cache_time');
          final now = DateTime.now().millisecondsSinceEpoch;
          if (cacheTime != null && (now - (cacheTime as int)) < 3600000) {
            emit(ProfileSuccessForDoctors(doctor: cachedDoctor));
            return;
          }
        }
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
            final doctor = doctors.firstWhere(
              (doctor) => doctor.id == userId,
              orElse: () => throw Exception('Doctor not found'),
            );
            // Always update cache with fresh data
            UserCacheHelper.cacheDoctorData(doctor);
            CacheHelper().saveData(
              key: 'doctor_cache_time',
              value: DateTime.now().millisecondsSinceEpoch,
            );
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

  Future<void> updateProfileForPatients(
      String table, Map<String, dynamic> data) async {
    emit(UpdateProfileLoadingForPatients());

    try {
      final supabase = Supabase.instance.client;

      final cachedPatient = await UserCacheHelper.getCachedPatientData();
      final userId = cachedPatient?.id ?? CacheHelper().getData(key: 'userId');
      if (userId == null) {
        emit(UpdateProfileErrorForPatients(error: 'User not authenticated'));
        return;
      }

      final response = await supabase
          .from(table)
          .update(data)
          .eq('id', userId)
          .select()
          .single();

      final updatedPatient = PatientsModel.fromJson(response);

      // Update cache with the complete patient data from server
      await UserCacheHelper.cachePatientData(updatedPatient);
      await CacheHelper().saveData(
        key: 'patient_cache_time',
        value: DateTime.now().millisecondsSinceEpoch,
      );

      emit(UpdateProfileSuccessForPatients(patient: updatedPatient));
    } catch (e) {
      emit(UpdateProfileErrorForPatients(error: e.toString()));
    }
  }

  Future<void> updateProfileForDoctors(
      String table, Map<String, dynamic> data) async {
    emit(UpdateProfileLoadingForDoctors());

    try {
      final supabase = Supabase.instance.client;

      final cachedDoctor = await UserCacheHelper.getCachedDoctorData();
      final userId = cachedDoctor?.id ?? CacheHelper().getData(key: 'userId');
      if (userId == null) {
        emit(UpdateProfileErrorForDoctors(error: 'User not authenticated'));
        return;
      }

      final response = await supabase
          .from(table)
          .update(data)
          .eq('id', userId)
          .select()
          .single();

      final updatedDoctor = DoctorsModel.fromJson(response);
      emit(UpdateProfileSuccessForDoctors(doctor: updatedDoctor));
    } catch (e) {
      emit(UpdateProfileErrorForDoctors(error: e.toString()));
    }
  }

  Future<void> fetchDoctorSchedule(String doctorId) async {
    emit(DoctorScheduleLoading());
    final result =
        await appointenentSchedualRepositorie.getAppointementSchedule(
      '${AppConstants.baseRestUrl}/rpc/get_doctor_availability',
      doctorId,
    );

    result.fold(
      (error) => emit(DoctorScheduleFailure(error)),
      (schedule) => emit(DoctorScheduleSuccess(schedule)),
    );
  }
}
