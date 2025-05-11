import 'package:dartz/dartz.dart';
import 'package:heal_care/core/errors/api/exceptions/api_exception.dart';
import 'package:heal_care/core/networking/api_services.dart';
import 'package:heal_care/features/patient_home/data/models/appointement_schedual_model.dart';

class AppointenentSchedualRepositorie {
  final ApiServices apiServices;

  AppointenentSchedualRepositorie({required this.apiServices});

  Future<Either<String, AppointementScheduleModel>> getAppointementSchedule(String path, String doctorId) async {
    try {
      final response = await apiServices.post(path, data: {
        "doctor_id_input": doctorId,
      });

      final model = AppointementScheduleModel.fromJson(response);
      return Right(model);
    } on ApiException catch (e) {
      return Left(e.errorModel.message ?? 'Unknown error');
    }
  }
}
