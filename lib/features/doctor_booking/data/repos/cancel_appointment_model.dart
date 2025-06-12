import 'package:dartz/dartz.dart';
import 'package:heal_care/core/errors/api/exceptions/api_exception.dart';
import 'package:heal_care/core/networking/api_services.dart';

import '../models/cancel_appointment_model.dart';

abstract class CancelAppointmentRepo {

  final ApiServices apiServices;

  CancelAppointmentRepo(this.apiServices);

  Future<Either<String, CancelAppointmentModel>> cancelAppointment(
      String path, Map<String, dynamic> data) async {
    try {
      final response = await apiServices.post(path, data: data);
      return Right(response);
    } on ApiException catch (e) {
      return Left(e.errorModel.message ?? 'Failed to cancel appointment');
    } catch (e) {
      return Left('Unexpected error: ${e.toString()}');
    }
  }
}