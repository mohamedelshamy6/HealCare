import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:heal_care/core/errors/api/exceptions/api_exception.dart';
import 'package:heal_care/core/networking/api_services.dart';
import 'package:heal_care/features/doctor_booking/data/models/doctor_booking_model.dart';

class DoctorBookingRepositories {
  final ApiServices apiServices;
  DoctorBookingRepositories(this.apiServices);

  Future<Either<String, List<DoctorBookingModel>>> getDoctorBooking(
    String path,
  ) async {
    try {
      final response = await apiServices.get(path);
      log("Response: $response");
      final List<DoctorBookingModel> doctorBooking = (response as List)
          .map((json) => DoctorBookingModel.fromJson(json))
          .toList();
      return right(doctorBooking);
    } on ApiException catch (e) {
      return left(e.errorModel.message!);
    } catch (e) {
      return left("Unexpected error${e.toString()}");
    }
  }
}
