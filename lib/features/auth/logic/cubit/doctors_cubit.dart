import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/features/auth/data/models/patient_favourotes_model.dart';
import 'package:heal_care/features/auth/data/repos/patient_favourites_repo.dart';
import 'package:heal_care/features/auth/data/repos/toogle_favourites_repo.dart';

import '../../../../core/helpers/app_constants.dart';
import '../../data/models/doctors_model.dart';
import '../../data/repos/doctors_repo.dart';

part 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  DoctorsCubit({
    required this.toogleFavouritesRepo,
    required this.doctorsRepo,
    required this.patientFavouritesRepo,
  }) : super(DoctorsInitial());

  final DoctorsRepo doctorsRepo;
  final PatientFavouritesRepo patientFavouritesRepo;
  final ToogleFavouritesRepo toogleFavouritesRepo;

  List<DoctorsModel> doctorsModel = [];
  List<PatientFavouritesModel> patientFavoritesModel = [];

  bool _isLoadingDoctors = false;

  Future<void> getAllDoctors() async {
    log('getAllDoctors called');
    if (_isLoadingDoctors) {
      log('Doctors already loading, skipping duplicate request');
      return;
    }

    _isLoadingDoctors = true;
    emit(DoctorsLoading());

    try {
      log('Fetching patient favorites...');
      final patientId = CacheHelper().getData(key: 'patient_Id') ??
          CacheHelper().getData(key: 'userId') ??
          '';
      log('Using patient ID: $patientId');

      // First get the favorites to ensure we have the latest favorite status
      final favResult = await patientFavouritesRepo.getPatientFavourites(
        '${AppConstants.baseRestUrl}rpc/get_patient_favorites',
        {
          'patient_id': patientId,
        },
      );

      log('Fetching doctors list...');
      // Then get the doctors list
      final doctorsResult =
          await doctorsRepo.getAllDoctors('${AppConstants.baseRestUrl}doctors');

      doctorsResult.fold(
        (error) {
          log('Error fetching doctors: $error');
          _isLoadingDoctors = false;
          emit(DoctorsFailure(error: error));
        },
        (doctorsList) {
          log('Successfully fetched ${doctorsList.length} doctors');

          favResult.fold(
            (error) {
              log('Error fetching favorites: $error');
              _isLoadingDoctors = false;
              emit(DoctorsFailure(error: error));
            },
            (favsList) {
              log('Successfully fetched ${favsList.length} favorites');

              // Update doctors with favorite status
              for (var doctor in doctorsList) {
                final isFavorite =
                    favsList.any((fav) => fav.doctorId == doctor.id);
                doctor.isFavourite = isFavorite;
                log('Doctor ${doctor.id} (${doctor.name}) favorite status: $isFavorite');
              }

              // Update both lists
              doctorsModel = doctorsList;
              patientFavoritesModel = favsList;
              _isLoadingDoctors = false;

              log('Emitting DoctorsSuccess with ${doctorsList.length} doctors');
              emit(DoctorsSuccess(doctorsModel: doctorsList));
              // Force a rebuild of the UI
              Future.microtask(
                  () => emit(DoctorsSuccess(doctorsModel: doctorsList)));
            },
          );
        },
      );
    } catch (e) {
      _isLoadingDoctors = false;
      log('Error in getAllDoctors: $e',
          error: e, stackTrace: StackTrace.current);
      emit(DoctorsFailure(error: e.toString()));
    }
  }

  Future<void> getPatientFavourites() async {
    emit(PatientFavouritesLoading());

    try {
      final result = await patientFavouritesRepo.getPatientFavourites(
        '${AppConstants.baseRestUrl}rpc/get_patient_favorites',
        {
          'patient_id': CacheHelper().getData(key: 'patient_Id') ??
              CacheHelper().getData(key: 'userId') ??
              '',
        },
      );

      result.fold(
        (error) {
          emit(PatientFavouritesFailure(error: error));
        },
        (favorites) {
          patientFavoritesModel = favorites;
          emit(PatientFavouritesSuccess(patientFavoritesModel: favorites));
        },
      );
    } catch (e) {
      emit(PatientFavouritesFailure(error: e.toString()));
    }
  }

  Future<void> addDoctor(String path, dynamic data) async {
    emit(DoctorsLoading());
    final response = await doctorsRepo.addDoctor(path, data);
    response.fold(
      (error) {},
      (success) {},
    );
  }

  Future<void> toggleFavouriteDoctor(DoctorsModel doctor) async {
    try {
      log('Toggling favorite for doctor: ${doctor.name} (${doctor.id})');

      final response = await toogleFavouritesRepo.toggleFavourite(
        '${AppConstants.baseRestUrl}rpc/toggle_favorite',
        {
          'patient': CacheHelper().getData(key: 'patient_Id') ??
              CacheHelper().getData(key: 'userId') ??
              '',
          'doctor': doctor.id ?? 'no doctor id',
        },
      );

      response.fold(
        (error) {
          log('Toggle favorite API error: $error');
          emit(PatientToogleFavouritesError(error: error));
        },
        (isFavorite) async {
          log('Toggle favorite successful. New status: $isFavorite');

          // Update the doctor's favorite status
          final updatedDoctors = List<DoctorsModel>.from(doctorsModel);
          final index = updatedDoctors.indexWhere((d) => d.id == doctor.id);

          if (index != -1) {
            updatedDoctors[index] =
                updatedDoctors[index].copyWith(isFavourite: isFavorite);
            doctorsModel = updatedDoctors;

            // Update the local favorites list
            if (isFavorite == true) {
              patientFavoritesModel.add(PatientFavouritesModel(
                doctorId: doctor.id,
                doctorName: doctor.name,
                doctorImage: doctor.image,
                specialization: doctor.specialization,
                averageRate: 0.0,
              ));
            } else {
              patientFavoritesModel
                  .removeWhere((fav) => fav.doctorId == doctor.id);
            }

            emit(PatientToogleFavouritesSuccess());
            emit(DoctorsSuccess(doctorsModel: doctorsModel));
          }
        },
      );
    } catch (e) {
      log('Error in toggleFavouriteDoctor: $e');
      emit(PatientToogleFavouritesError(error: e.toString()));
      rethrow; // Rethrow to handle in the UI
    }
  }

  Future<void> removeFromFavourites(PatientFavouritesModel favorite) async {
    try {
      // Find and update the doctor in doctorsModel
      final doctorIndex =
          doctorsModel.indexWhere((d) => d.id == favorite.doctorId);
      if (doctorIndex != -1) {
        final updatedDoctors = List<DoctorsModel>.from(doctorsModel);
        updatedDoctors[doctorIndex] =
            updatedDoctors[doctorIndex].copyWith(isFavourite: false);
        doctorsModel = updatedDoctors;
      }

      // Remove from favorites list
      patientFavoritesModel
          .removeWhere((fav) => fav.doctorId == favorite.doctorId);

      // Update server
      await toogleFavouritesRepo.toggleFavourite(
        '${AppConstants.baseRestUrl}rpc/toggle_favorite',
        {
          'patient': CacheHelper().getData(key: 'patient_Id') ??
              CacheHelper().getData(key: 'userId') ??
              '',
          'doctor': favorite.doctorId ?? 'no doctor id',
        },
      );

      // Emit both states to ensure all screens are updated
      emit(PatientFavouritesSuccess(
          patientFavoritesModel: patientFavoritesModel));
      emit(DoctorsSuccess(doctorsModel: doctorsModel));

      // Refresh the doctors list to ensure everything is in sync
      await getAllDoctors();
    } catch (e) {
      log('Error in removeFromFavourites: $e');
      emit(PatientToogleFavouritesError(error: e.toString()));
    }
  }
}
