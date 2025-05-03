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
      return Left(e.errorModel.message!);
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
      return Left(e.errorModel.message!);
    }
  }
}
