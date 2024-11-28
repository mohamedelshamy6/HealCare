import 'package:get_it/get_it.dart';
import '../networking/api_services.dart';
import '../networking/dio_handler.dart';

class DependencyInjection {
  static final getIt = GetIt.instance;

  Future<void> setupGetIt() async {
    // Dio & ApiService
    getIt.registerLazySingleton<ApiServices>(() => DioHandler());

  }
}
