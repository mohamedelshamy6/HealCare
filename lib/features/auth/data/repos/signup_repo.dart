import 'package:dartz/dartz.dart';
import '../../../../core/errors/api/exceptions/api_exception.dart';

import '../models/sign_up_model.dart';

import '../../../../core/networking/api_services.dart';

class SignUpRepo {
  late ApiServices apiServices;
  SignUpRepo(this.apiServices);
  Future<Either<String, SignUpModel>> signUp(
    String path,
    dynamic data,
  ) async {
    try {
      var response = await apiServices.post(
        path,
        data: data,
      );
      var result = SignUpModel.fromJson(response);
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }
}
