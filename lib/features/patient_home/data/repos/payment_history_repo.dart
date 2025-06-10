import 'package:dartz/dartz.dart';
import 'package:heal_care/core/errors/api/exceptions/api_exception.dart';
import 'package:heal_care/core/networking/api_services.dart';
import 'package:heal_care/features/patient_home/data/models/payment_history_model.dart';

class PaymentHistoryRepo {
  final ApiServices apiServices;
  PaymentHistoryRepo(this.apiServices);

  Future<Either<String, List<PaymentsHistoryModel>>> getPaymentHistory(
      String path, Map<String, dynamic> data) async {
    try {
      final response = await apiServices.post(path, data: data);
      if (response is List) {
        return Right(response
            .map((payment) => PaymentsHistoryModel.fromJson(payment))
            .toList()
            .cast<PaymentsHistoryModel>());
      } else {
        return Left('Unexpected response format');
      }
    } on ApiException catch (e) {
      return Left(e.errorModel.message ?? 'API Error');
    } catch (e) {
      return Left('An unexpected error occurred: ${e.toString()}');
    }
  }
}
