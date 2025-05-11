import 'package:dartz/dartz.dart';
import 'package:heal_care/core/errors/api/exceptions/api_exception.dart';
import 'package:heal_care/core/networking/api_services.dart';

class AppointenentSchedualRepositorie {
  final ApiServices apiServices;
  AppointenentSchedualRepositorie({required this.apiServices});

  Future<Either<String, List<AppointenentSchedualRepositorie>>>
      getAppointementSchedule(String path) async {
    try {
      final response = await apiServices.post(path);

      return Right(response);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }
}
