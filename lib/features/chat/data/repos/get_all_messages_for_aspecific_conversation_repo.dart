import 'package:dartz/dartz.dart';
import 'package:heal_care/core/errors/api/exceptions/api_exception.dart';
import 'package:heal_care/core/networking/api_services.dart';
import 'package:heal_care/features/chat/data/models/get_all_messages_for_aspecific_conversation_model.dart';

class GetAllMessagesForAspecificConversationRepo {
  final ApiServices apiServices;

  GetAllMessagesForAspecificConversationRepo(this.apiServices);
  Future<Either<String, List<GetAllMessagesForAspecificConversationModel>>>
      getAllMessagesForAspecificConversation(
          String path, String conversationId, String order) async {
    try {
      final response = await apiServices.get(
        path,
        queryParameters: {
          'conversation_id': 'eq.$conversationId',
          'order': 'sent_at.asc',
        },
      );
      final List<GetAllMessagesForAspecificConversationModel> messages =
          (response as List)
              .map((e) =>
                  GetAllMessagesForAspecificConversationModel.fromJson(e))
              .toList();
      return Right(messages);
    } on ApiException catch (e) {
      return Left(e.errorModel.message ?? 'Something went wrong');
    }
  }
}
