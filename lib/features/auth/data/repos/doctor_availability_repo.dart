import 'package:dartz/dartz.dart';
import '../../../../core/errors/api/exceptions/api_exception.dart';
import '../../../../core/networking/api_services.dart';

class DoctorAvailabilityRepo {
  late ApiServices apiServices;
  DoctorAvailabilityRepo(this.apiServices);

  Future<Either<String, String>> addDoctorAvailability(
    String path,
    dynamic data,
  ) async {
    try {
      var response = await apiServices.post(
        path,
        data: data,
      );
      return Right('Success');
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }
}
