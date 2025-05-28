import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/auth/logic/cubit/patients_cubit.dart';
import 'package:heal_care/features/chat/data/repos/create_conversition_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.conversitionRepository, this.doctorsCubit, this.patientsCubit)
      : super(ChatInitial());

  final CreateConversitionRepository conversitionRepository;

  final DoctorsCubit doctorsCubit;
  final PatientsCubit patientsCubit;

  Future<void> createConversation() async {
    emit(CreateChatConversitionLoading());
    var result = await conversitionRepository.createConversition(
      path: '${AppConstants.baseRestUrl}conversations',
      body: {
        'doctor_id': doctorsCubit.doctorsModel.first.id,
        'patient_id': patientsCubit.patientsModel.first.id,
      },
    );
    result.fold(
      (error) => emit(CreateChatConversitionFailure(error)),
      (_) {
        emit(CreateChatConversitionSuccess());
      },
    );
  }
}
