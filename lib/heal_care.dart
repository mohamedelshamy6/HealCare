import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/dependency_injection/dependency_injection.dart';
import 'core/routing/app_routes.dart';
import 'core/routing/routes.dart';
import 'features/auth/logic/cubit/doctors_cubit.dart';
import 'features/auth/logic/cubit/patients_cubit.dart';

class HealCare extends StatelessWidget {
  const HealCare({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //* The size of the screen of figma design.
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                DoctorsCubit(doctorsRepo: DependencyInjection.getIt()),
          ),
          BlocProvider(
            create: (context) =>
                PatientsCubit(patientsRepo: DependencyInjection.getIt()),
          ),
        ],
        child: MaterialApp(
          initialRoute: Routes.splash,
          onGenerateRoute: AppRoutes().generateRoute,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              elevation: 0,
              color: Colors.white,
              surfaceTintColor: Colors.white,
              scrolledUnderElevation: 0,
            ),
            scaffoldBackgroundColor: const Color(0xffF9f9f9),
            useMaterial3: true,
            brightness: Brightness.light,
          ),
        ),
      ),
    );
  }
}
