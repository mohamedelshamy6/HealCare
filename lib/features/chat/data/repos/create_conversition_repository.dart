import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:heal_care/core/errors/api/exceptions/api_exception.dart';
import 'package:heal_care/core/networking/api_services.dart';
import 'package:heal_care/features/chat/data/models/create_conversation_model.dart';

class CreateConversitionRepository {
  final ApiServices apiServices;
  CreateConversitionRepository(this.apiServices);
Future<Either<String, List<CreateConversationModel>>> createConversition({
    required String path,
    required dynamic body,
  }) async {
    try {
     final response = await apiServices.post(path, data: body);
     final List<CreateConversationModel> conversations = (response as List)
            .map((e) => CreateConversationModel.fromJson(e))
            .toList();
            log(conversations.toString());
      return Right(conversations);
      
    } on ApiException catch (e) {
      return Left(e.errorModel.message ?? 'Error in createConversition');
    } catch (e) {
      return Left(e.toString());
    }
  }

}