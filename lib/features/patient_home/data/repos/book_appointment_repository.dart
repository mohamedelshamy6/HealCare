import 'package:dartz/dartz.dart';
import 'package:heal_care/core/errors/api/exceptions/api_exception.dart';
import 'package:heal_care/core/networking/api_services.dart';

class BookAppointmentRepository {
  final ApiServices apiServices;
  BookAppointmentRepository(this.apiServices);

  Future<Either<String, bool>> createAppointment({
  required String path,
  required dynamic body,
}) async {
  try {
    await apiServices.post(
      path,
      data: body,
    );

    return const Right(true);
  } on ApiException catch (e) {
    return Left(e.errorModel.message ??
        'There is No Available Appointment for this Doctor');
  } catch (e) {
    return Left('There is an Error: ${e.toString()}');
  }
}

}
