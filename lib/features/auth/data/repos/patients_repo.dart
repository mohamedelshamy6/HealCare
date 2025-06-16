import 'package:dartz/dartz.dart';

import '../../../../core/errors/api/exceptions/api_exception.dart';
import '../../../../core/networking/api_services.dart';
import '../models/patients_model.dart';

class PatientsRepo {
  late ApiServices apiServices;
  PatientsRepo(this.apiServices);
  
  Future<Either<String, List<PatientsModel>>> getAllPatients(
      String path) async {
    try {
      var response = await apiServices.get(path);
      var result = (response as List)
          .map((patient) => PatientsModel.fromJson(patient))
          .toList();
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message ?? 'Failed to fetch patients');
    } catch (e) {
      return Left('Unexpected error: ${e.toString()}');
    }
  }

  // Method for getting a single patient by ID
  // This assumes your API supports /patients/{id} endpoint
  Future<Either<String, PatientsModel?>> getSinglePatientById(
      String path) async {
    try {
      var response = await apiServices.get(path);
      
      // If the API returns a single patient object
      if (response is Map<String, dynamic>) {
        var result = PatientsModel.fromJson(response);
        return Right(result);
      }
      // If the API returns an array with one patient
      else if (response is List && response.isNotEmpty) {
        var result = PatientsModel.fromJson(response.first);
        return Right(result);
      }
      else {
        return const Right(null);
      }
    } on ApiException catch (e) {
      return Left(e.errorModel.message ?? 'Failed to fetch patient');
    } catch (e) {
      return Left('Unexpected error: ${e.toString()}');
    }
  }

  // Keep the old method for backward compatibility
  // This method gets all patients and you filter on the client side
  Future<Either<String, List<PatientsModel>>> getPatientById(
      String path) async {
    try {
      var response = await apiServices.get(path);
      var result = (response as List)
          .map((patient) => PatientsModel.fromJson(patient))
          .toList();
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message ?? 'Failed to fetch patients');
    } catch (e) {
      return Left('Unexpected error: ${e.toString()}');
    }
  }

  Future<Either<String, String>> addPatient(
    String path,
    dynamic data,
  ) async {
    try {
      await apiServices.post(
        path,
        data: data,
      );
      var result = 'Successfully added patient';
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message ?? 'Failed to add patient');
    } catch (e) {
      return Left('Unexpected error: ${e.toString()}');
    }
  }

  // Method to update patient data
  Future<Either<String, String>> updatePatient(
    String path,
    dynamic data,
  ) async {
    try {
      await apiServices.update(
        path,
        data: data,
      );
      var result = 'Successfully updated patient';
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message ?? 'Failed to update patient');
    } catch (e) {
      return Left('Unexpected error: ${e.toString()}');
    }
  }
}