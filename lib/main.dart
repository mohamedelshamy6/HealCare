import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heal_care/core/helpers/helper_methods.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';
import 'heal_care.dart';
import 'core/dependency_injection/dependency_injection.dart';
import 'core/helpers/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  //? A list of future methods or dependencies that need to be initialized.
  await Future.wait([
    ScreenUtil.ensureScreenSize(),
    DependencyInjection().setupGetIt(),
    GoogleFonts.pendingFonts([
      GoogleFonts.poppins(),
    ]),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    Supabase.initialize(
      url: 'https://hftivyxotfavjvrukbts.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhmdGl2eXhvdGZhdmp2cnVrYnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI5NDEwNDIsImV4cCI6MjA0ODUxNzA0Mn0.lV9hHj2M12KpWO1mINsfmw-uOH43ki99pTp16Xk23XQ',
    ),
    HelperMethods.checkAndRefreshToken(),
  ]);

  //? Load the google fonts to solve the loading bug.
  GoogleFonts.config.allowRuntimeFetching = false;

  //? Adding a font license in the application.
  LicenseRegistry.addLicense(
    () async* {
      final license =
          await rootBundle.loadString('assets/fonts/poppins/OFL.txt');
      yield LicenseEntryWithLineBreaks(
        ['assets/fonts/poppins'],
        license,
      );
    },
  );

  //? To set the orientation of the device to portrait and can not rotate.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    runApp(const HealCare());
  });
}
