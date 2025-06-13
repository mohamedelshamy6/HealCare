import 'dart:convert';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';
import 'cache_helper.dart';

class UserCacheHelper {
  static const String _doctorCacheKey = 'cached_doctor_data';
  static const String _patientCacheKey = 'cached_patient_data';

  static Future<void> cacheDoctorData(DoctorsModel doctor) async {
    final cacheHelper = CacheHelper();
    await cacheHelper.saveData(
      key: _doctorCacheKey,
      value: jsonEncode(doctor.toJson()),
    );
  }

  static Future<void> cachePatientData(PatientsModel patient) async {
    final cacheHelper = CacheHelper();
    await cacheHelper.saveData(
      key: _patientCacheKey,
      value: jsonEncode(patient.toJson()),
    );
  }

  static Future<DoctorsModel?> getCachedDoctorData() async {
    final cacheHelper = CacheHelper();
    final cachedData = cacheHelper.getDataString(key: _doctorCacheKey);
    if (cachedData != null) {
      try {
        return DoctorsModel.fromJson(jsonDecode(cachedData));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  static Future<PatientsModel?> getCachedPatientData() async {
    final cacheHelper = CacheHelper();
    final cachedData = cacheHelper.getDataString(key: _patientCacheKey);
    if (cachedData != null) {
      try {
        return PatientsModel.fromJson(jsonDecode(cachedData));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  static Future<void> clearUserCache() async {
    final cacheHelper = CacheHelper();
    await cacheHelper.removeData(key: _doctorCacheKey);
    await cacheHelper.removeData(key: _patientCacheKey);
  }
}
