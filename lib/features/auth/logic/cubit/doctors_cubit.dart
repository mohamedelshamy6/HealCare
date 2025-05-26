import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/app_constants.dart';
import '../../data/models/doctors_model.dart';
import '../../data/repos/doctors_repo.dart';

part 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  DoctorsCubit({required this.doctorsRepo}) : super(DoctorsInitial());

  final DoctorsRepo doctorsRepo;
  List<DoctorsModel> doctorsModel = [];
  Future<void> getAllDoctors() async {
    emit(DoctorsLoading());
    final doctorsModel =
        await doctorsRepo.getAllDoctors('${AppConstants.baseRestUrl}doctors');
    doctorsModel.fold((error) {
      emit(DoctorsFailure(error: error));
    }, (doctorsModel) {
      this.doctorsModel = doctorsModel;
      emit(DoctorsSuccess(doctorsModel: doctorsModel));
    });
  }

  Future<void> addDoctor(
    String path,
    dynamic data,
  ) async {
    emit(DoctorsLoading());
    final response = await doctorsRepo.addDoctor(
      path,
      data,
    );
    response.fold((error) {}, (succsess) {});
  }
}
