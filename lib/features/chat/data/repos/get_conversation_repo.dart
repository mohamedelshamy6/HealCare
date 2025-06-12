import 'package:dartz/dartz.dart';
import 'package:heal_care/core/errors/api/exceptions/api_exception.dart';
import 'package:heal_care/core/networking/api_services.dart';
import 'package:heal_care/features/chat/data/models/get_conversations_model.dart';

class  GetConversationRepo {
  final ApiServices apiServices;

  GetConversationRepo({required this.apiServices});

  Future<Either<String,List<GetConversationsModel>>> getConversations(
    String path,Map<String,dynamic> data
  ) async {
    try {
      final response = await apiServices.get(path, data: data);
      return Right(response.map((e) => GetConversationsModel.fromJson(e)).toList());
    } on ApiException catch (e) {
      return Left(e.errorModel.message.toString());
    } 
  }
}
