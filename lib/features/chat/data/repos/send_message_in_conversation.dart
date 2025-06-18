import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:heal_care/core/errors/api/exceptions/api_exception.dart';
import 'package:heal_care/core/networking/api_services.dart';

class SendMessageInConversation {
  final ApiServices apiServices;
  SendMessageInConversation(this.apiServices);

  Future<Either<String, bool>> sendMessageInConversation({
    required String path,
    required dynamic body,
  }) async {
    try {
      await apiServices.post(path, data: body);
      log('Message sent successfully');
      return const Right(true);

    } on ApiException catch (e) {
      return Left(e.errorModel.message ?? 'Error');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
