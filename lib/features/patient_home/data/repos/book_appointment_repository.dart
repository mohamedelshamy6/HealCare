import 'package:dartz/dartz.dart';
import 'package:heal_care/core/errors/api/exceptions/api_exception.dart';
import 'package:heal_care/core/networking/api_services.dart';

class BookAppointmentRepository {
  final ApiServices apiServices;
  BookAppointmentRepository(this.apiServices);

  Future<Either<String, bool>> createAppointment({
    required String path,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await apiServices.post(
        path,
        data: body,
      );

      if (response != null && response['statusCode'] == 200) {
        return const Right(true);
      }

      return const Right(true);
    } on ApiException catch (e) {
      return Left(e.errorModel.message ??
          'There is No Avaliable Appointment for this Doctor');
    } catch (e) {
      return Left('there is an Error : ${e.toString()}');
    }
  }
}
