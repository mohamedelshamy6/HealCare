import 'package:dartz/dartz.dart';
import 'package:heal_care/core/networking/api_services.dart';


class ToogleFavouritesRepo {
  final ApiServices apiServices;
  ToogleFavouritesRepo(this.apiServices);

  Future<Either<String, bool>> toggleFavourite(String path, Map<String, dynamic> data) async {
    try {
      final response = await apiServices.post(path, data: data);
      if (response is bool) {
        return Right(response);
      } else {
        return Left('Unexpected response format');
      }
    } catch (e) {
      return Left('An error occurred while toggling favourite: ${e.toString()}');
    }
  }
}
