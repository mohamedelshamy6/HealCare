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
