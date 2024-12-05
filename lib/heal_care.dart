import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/routing/app_routes.dart';
import 'core/routing/routes.dart';

class HealCare extends StatelessWidget {
  const HealCare({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //* The size of the screen of figma design.
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => MaterialApp(
        initialRoute: Routes.splash,
        builder: DevicePreview.appBuilder,
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
    );
  }
}
