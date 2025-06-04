part of 'chat_cubit.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class CreateChatConversitionLoading extends ChatState {}

final class CreateChatConversitionSuccess extends ChatState {}

final class CreateChatConversitionFailure extends ChatState {
  final String error;

  CreateChatConversitionFailure(this.error);
}
