import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:heal_care/core/errors/api/exceptions/api_exception.dart';
import 'package:heal_care/core/networking/api_services.dart';
import 'package:heal_care/features/patient_home/data/models/appointement_schedual_model.dart';
import 'dart:developer' as developer;

class AppointenentSchedualRepositorie {
  final ApiServices apiServices;

  AppointenentSchedualRepositorie({required this.apiServices});

  Future<Either<String, AppointementScheduleModel>> getAppointementSchedule(
    String path,
    String doctorId,
  ) async {
    try {
      final response = await apiServices.post(path, data: {
        "doctor_id_input": doctorId,
      });

      log('Raw API Response: $response');

      if (response == null || response is! Map<String, dynamic>) {
        return Left("there is No Avaliable Appointment for this Doctor");
      }

      final model = AppointementScheduleModel.fromJson(response);
      developer.log('Parsed Schedule Model: ${model.toJson()}');
      return Right(model);
    } on ApiException catch (e) {
      developer.log('API Exception: ${e.errorModel.message}');
      return Left(e.errorModel.message ?? 'Unknown error');
    } catch (e) {
      developer.log('Unexpected error: $e');
      return Left('Unexpected error: ${e.toString()}');
    }
  }
}
