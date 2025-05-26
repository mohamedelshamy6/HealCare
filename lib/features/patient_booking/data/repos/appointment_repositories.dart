import 'package:dartz/dartz.dart';
import 'package:heal_care/core/errors/api/exceptions/api_exception.dart';
import 'package:heal_care/core/networking/api_services.dart';
import 'package:heal_care/features/patient_booking/data/model/appoientment_model.dart';

class AppointmentRepositories {
  final ApiServices apiServices;

  AppointmentRepositories(this.apiServices);

  Future<Either<String, List<AppointmentModel>>> getAppointments(
       String path) async {
    try {
      final response = await apiServices
          .get(path);
      final List<AppointmentModel> appointments = (response as List)
          .map((json) => AppointmentModel.fromJson(json))
          .toList();
      return right(appointments);
    } on ApiException catch (e) {
      return left(e.errorModel.message ?? 'feild to get data');
    } catch (e) {
      return left("Unexpected error${e.toString()}");
    }
  }
}