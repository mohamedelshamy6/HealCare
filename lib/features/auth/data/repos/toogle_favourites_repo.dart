import 'package:heal_care/core/networking/api_services.dart';

class ToogleFavouritesRepo {
  final ApiServices apiServices;
  ToogleFavouritesRepo(this.apiServices);

  Future<bool> toggleFavourite(String path, Map<String, dynamic> data) async {
    try {
      final response = await apiServices.post(path, data: data);
      if (response is bool) {
        return response;
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      throw Exception('An error occurred while toggling favourite: ${e.toString()}');
    }
  }
}
