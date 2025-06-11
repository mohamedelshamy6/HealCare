import 'package:dartz/dartz.dart';
import 'package:heal_care/core/networking/api_services.dart';
import 'package:heal_care/features/auth/data/models/patient_favourotes_model.dart';

class PatientFavouritesRepo {
  final ApiServices apiServices;
  PatientFavouritesRepo(this.apiServices);

  Future<Either<String,List<PatientFavouritesModel>>> getPatientFavourites(
      String path, Map<String, dynamic> data) async {
    try {
      final response = await apiServices.post(path, data: data);
      if (response is List) {
        return Right(response
            .map((fav) => PatientFavouritesModel.fromJson(fav))
            .toList()
            .cast<PatientFavouritesModel>());
      } else {
        return Left('Unexpected response format');
      }
    } catch (e) {
      return Left('An unexpected error occurred: ${e.toString()}');
    }
  }
}
