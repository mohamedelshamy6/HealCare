import 'package:get_it/get_it.dart';
import 'package:heal_care/features/auth/data/repos/login_repo.dart';
import 'package:heal_care/features/auth/data/repos/signup_repo.dart';

import '../networking/api_services.dart';
import '../networking/dio_handler.dart';

class DependencyInjection {
  static final getIt = GetIt.instance;

  Future<void> setupGetIt() async {
    // Dio & ApiService
    getIt.registerLazySingleton<ApiServices>(() => DioHandler());

    // Repositories
    getIt.registerLazySingleton<LoginRepo>(
        () => LoginRepo(getIt<ApiServices>()));
    getIt.registerLazySingleton<SignUpRepo>(
        () => SignUpRepo(getIt<ApiServices>()));
  }
}
