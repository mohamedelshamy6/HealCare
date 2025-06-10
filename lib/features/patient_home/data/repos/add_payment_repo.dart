import 'package:dartz/dartz.dart';
import 'package:heal_care/core/errors/api/exceptions/api_exception.dart';
import 'package:heal_care/core/networking/api_services.dart';
import 'package:heal_care/features/patient_home/data/models/add_payment_model.dart';

class AddPaymentRepo {
  final ApiServices apiServices;

  AddPaymentRepo(this.apiServices);


  Future<Either<String, AddPaymentModel>> addPayment(
      String path, Map<String, dynamic> data) async {
    try {
      final response = await apiServices.post(path, data: data);
      return Right(response);
    } on ApiException catch (e) {
      return Left(e.errorModel.message ?? 'Failed to add payment');
    } catch (e) {
      return Left('Unexpected error: ${e.toString()}');
    }
  }
}
