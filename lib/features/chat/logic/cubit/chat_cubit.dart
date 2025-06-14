import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/auth/logic/cubit/patients_cubit.dart';
import 'package:heal_care/features/chat/data/models/get_conversations_model.dart';
import 'package:heal_care/features/chat/data/repos/create_conversition_repository.dart';
import 'package:heal_care/features/chat/data/repos/get_conversation_repo.dart';
import 'package:heal_care/features/chat/data/repos/send_message_in_conversation.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.conversitionRepository, this.getConversationRepo,
      this.sendMessageInConversation, this.doctorsCubit, this.patientsCubit)
      : super(ChatInitial());

  final CreateConversitionRepository conversitionRepository;
  final GetConversationRepo getConversationRepo;
  final SendMessageInConversation sendMessageInConversation;
  final DoctorsCubit doctorsCubit;
  final PatientsCubit patientsCubit;

  Future<void> createConversation({
    required String doctorId,
    required String patientId,
  }) async {
    if (isClosed) return;

    emit(CreateChatConversitionLoading());

    final result = await conversitionRepository.createConversition(
      path: '${AppConstants.baseRestUrl}conversations',
      body: {
        'doctor_id': doctorId,
        'patient_id': patientId,
      },
    );

    if (isClosed) return;

    result.fold(
      (error) => emit(CreateChatConversitionFailure(error)),
      (_) => emit(CreateChatConversitionSuccess()),
    );
  }

  Future<void> getConversations({
    required String userId,
    required String userType,
  }) async {
    emit(GetChatConversitionLoading());

    final result = await getConversationRepo.getConversations(
      '${AppConstants.baseRestUrl}rpc/get_user_conversations',
      {
        'user_id': userId,
        'user_type': userType,
      },
    );

    result.fold(
      (error) => emit(GetChatConversitionFailure(error)),
      (conversations) => emit(GetChatConversitionSuccess(conversations)),
    );
  }

  Future<void> sendMessageinConversation({
    required String conversationId,
    required String senderId,
    required String content,
    required String senderType,
  }) async {
    emit(SendMessageInConversationLoading());

    final result = await sendMessageInConversation.sendMessageInConversation(
      path: '${AppConstants.baseRestUrl}messages',
      body: {
        'conversation_id': conversationId,
        'sender_id': senderId,
        'content': content,
        'sender_type': senderType,
      },
    );

    result.fold(
      (error) => emit(SendMessageInConversationFailure(error)),
      (_) => emit(SendMessageInConversationSuccess()),
    );
  }
}
