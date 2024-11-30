import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'heal_care.dart';

import 'core/dependency_injection/dependency_injection.dart';
import 'core/helpers/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //? A list of future methods or dependencies that need to be initialized.
  Future.wait([
    ScreenUtil.ensureScreenSize(),
    DependencyInjection().setupGetIt(),
    CacheHelper().init(),
    GoogleFonts.pendingFonts([
      GoogleFonts.poppins(),
    ]),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
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
    runApp(const HealCare());
  });
}
