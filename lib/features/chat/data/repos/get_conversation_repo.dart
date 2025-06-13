import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:heal_care/core/errors/api/exceptions/api_exception.dart';
import 'package:heal_care/core/networking/api_services.dart';
import 'package:heal_care/features/chat/data/models/get_conversations_model.dart';

class GetConversationRepo {
  final ApiServices apiServices;

  GetConversationRepo(this.apiServices);

  Future<Either<String, List<GetConversationsModel>>> getConversations(
    String path,
    Map<String, dynamic> data,
  ) async {
    try {
      log('GetConversationRepo - Making API call to: $path');
      log('GetConversationRepo - Request data: $data');

      final response = await apiServices.post(path, data: data);
      log('GetConversationRepo - Raw response: $response');

      // Ensure response is a List
      if (response is! List) {
        log('GetConversationRepo - Error: Response is not a list. Type: ${response.runtimeType}');
        return Left('Invalid response format: expected a list');
      }

      // Convert each item in the list to GetConversationsModel
      final List<GetConversationsModel> conversations = response.map((item) {
        log('GetConversationRepo - Converting item: $item');
        return GetConversationsModel.fromJson(item as Map<String, dynamic>);
      }).toList();

      log('GetConversationRepo - Successfully converted ${conversations.length} conversations');
      return Right(conversations);
    } on ApiException catch (e) {
      log('GetConversationRepo - API Exception: ${e.errorModel.message}');
      return Left(e.errorModel.message.toString());
    } catch (e) {
      log('GetConversationRepo - Unexpected error: $e');
      return Left(e.toString());
    }
  }
}
