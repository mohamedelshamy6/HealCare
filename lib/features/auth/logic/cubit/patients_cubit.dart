
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/app_constants.dart';
import '../../data/models/patients_model.dart';
import '../../data/repos/patients_repo.dart';

part 'patients_state.dart';

class PatientsCubit extends Cubit<PatientsState> {
  PatientsCubit({required this.patientsRepo}) : super(PatientsInitial());

  final PatientsRepo patientsRepo;
  List<PatientsModel> patientsModel=[];
  Future<void> getAllPatients() async {
    emit(PatientsLoading());
    final patientsModel = await patientsRepo
        .getAllPatients('${AppConstants.baseRestUrl}patients');
    patientsModel.fold((error) {
      emit(PatientsFailure(error: error));
    }, (patientsModel) {
      this.patientsModel = patientsModel;
      emit(PatientsSuccess(patientsModel: patientsModel));
    });
  }

  Future<void> addPatient(
    String path,
    dynamic data,
  ) async {
    emit(PatientsLoading());
    final response = await patientsRepo.addPatient(
      path,
      data,
    );
    response.fold((error) {}, (success) {});
  }
}
