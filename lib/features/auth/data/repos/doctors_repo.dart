import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';

import '../../../../core/dependency_injection/dependency_injection.dart';
import '../../../../core/errors/api/exceptions/api_exception.dart';

import '../../../../core/networking/api_services.dart';
import '../../../../core/networking/supabase_web_socket_services.dart';

class DoctorsRepo {
  late ApiServices apiServices;
  DoctorsRepo(this.apiServices);
  Future<Either<String, List<DoctorsModel>>> getAllDoctors(String path) async {
    log('Fetching doctors from: $path');
    try {
      var response = await apiServices.get(path);
      log('Received response: $response');

      if (response is! List) {
        log('Error: Expected List but got ${response.runtimeType}');
        return Left('Invalid response format: Expected List');
      }

      var result = response.map((doctor) {
        try {
          return DoctorsModel.fromJson(doctor);
        } catch (e) {
          log('Error parsing doctor: $e');
          log('Problematic doctor data: $doctor');
          rethrow;
        }
      }).toList();

      log('Successfully parsed ${result.length} doctors');
      return Right(result);
    } on ApiException catch (e) {
      log('API Error: ${e.errorModel.message}');
      log('API Error details: ${e.toString()}');
      return Left(e.errorModel.message ?? 'Failed to fetch doctors');
    } catch (e, stackTrace) {
      log('Unexpected error in getAllDoctors: $e');
      log('Stack trace: $stackTrace');
      return Left('Failed to fetch doctors: $e');
    }
  }

  Future<Either<String, List<DoctorsModel>>> getDoctorById(String path) async {
    try {
      var response = await apiServices.get(path);
      var result = (response as List)
          .map((doctor) => DoctorsModel.fromJson(doctor))
          .toList();
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }

  Future<Either<String, String>> addDoctor(
    String path,
    dynamic data,
  ) async {
    try {
      await apiServices.post(
        path,
        data: data,
      );
      var result = 'Successfully added doctor';
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }

  Future<Either<String, String>> updateDoctor(
    String path,
    dynamic data,
  ) async {
    try {
      await apiServices.update(
        path,
        data: data,
      );
      var result = 'Successfully updated doctor';
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }

  Future<Either<String, String>> deleteDoctor(String path) async {
    try {
      await apiServices.delete(path);
      var result = 'Successfully deleted doctor';
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }

  Future<Either<String, List<DoctorsModel>>> listenToDoctors() async {
    List<DoctorsModel> doctorsList = [];
    try {
      DependencyInjection.getIt<SupabaseWebSocketService>()
          .listenToTable(tableName: 'doctors', onDataChanged: (payload) {});
      return Right(doctorsList);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }
}
