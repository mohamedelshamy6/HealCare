import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/features/auth/data/models/patient_favourotes_model.dart';
import 'package:heal_care/features/auth/data/repos/patient_favourites_repo.dart';

import '../../../../core/helpers/app_constants.dart';
import '../../data/models/doctors_model.dart';
import '../../data/repos/doctors_repo.dart';

part 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  DoctorsCubit({required this.doctorsRepo, required this.patientFavouritesRepo})
      : super(DoctorsInitial());

  final DoctorsRepo doctorsRepo;
  List<DoctorsModel> doctorsModel = [];
  List<PatientFavouritesModel> patientFavoritesModel = [];
  final PatientFavouritesRepo patientFavouritesRepo;
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

  Future<void> getPatientFavourites() async {
    emit(PatientFavouritesLoading());

    final String patientId = CacheHelper().getData(key: 'patient_Id') ??
        CacheHelper().getData(key: 'userId') ??
        'No Id for Patient';
        log('Patient ID: $patientId');
    final response = await patientFavouritesRepo.getPatientFavourites(
      '${AppConstants.baseRestUrl}rpc/get_patient_favorites',
      {
        'patient_id': patientId
      },
    );
    response.fold((error) {
      emit(PatientFavouritesFailure(error: error));
    }, (patientFavoritesModel) {
      this.patientFavoritesModel = patientFavoritesModel;
      emit(PatientFavouritesSuccess(patientFavoritesModel: patientFavoritesModel));
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
