part of 'chat_cubit.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class CreateChatConversitionLoading extends ChatState {}

final class CreateChatConversitionSuccess extends ChatState {}

final class CreateChatConversitionFailure extends ChatState {
  final String error;

  CreateChatConversitionFailure(this.error);
}

final class GetChatConversitionLoading extends ChatState {}

final class GetChatConversitionSuccess extends ChatState {
  final List<GetConversationsModel> conversations;

  GetChatConversitionSuccess(this.conversations);
}

final class GetChatConversitionFailure extends ChatState {
  final String error;

  GetChatConversitionFailure(this.error);
}

final class SendMessageInConversationLoading extends ChatState {}

final class SendMessageInConversationSuccess extends ChatState {}

final class SendMessageInConversationFailure extends ChatState {
  final String error;

  SendMessageInConversationFailure(this.error);
}

final class GetAllMessagesForAspecificConversationLoading extends ChatState {}

final class GetAllMessagesForAspecificConversationSuccess extends ChatState {
  final List<GetAllMessagesForAspecificConversationModel> messages;

  GetAllMessagesForAspecificConversationSuccess({required this.messages});
}

final class GetAllMessagesForAspecificConversationFailure extends ChatState {
  final String error;

  GetAllMessagesForAspecificConversationFailure({required this.error});
}

final class GetMessagesForConversationLoading extends ChatState {}

final class GetMessagesForConversationSuccess extends ChatState {
  final List<GetAllMessagesForAspecificConversationModel> messages;

  GetMessagesForConversationSuccess(this.messages);
}

final class GetMessagesForConversationFailure extends ChatState {
  final String error;

  GetMessagesForConversationFailure(this.error);
}
