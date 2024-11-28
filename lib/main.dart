import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heal_care/firebase_options.dart';
import 'package:heal_care/heal_care.dart';

import 'core/dependency_injection/dependency_injection.dart';
import 'core/helpers/cache_helper.dart';

bool? showOnBoarding;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //? A list of future methods or dependencies that need to be initialized.
  Future.wait([
    ScreenUtil.ensureScreenSize(),
    DependencyInjection().setupGetIt(),
    CacheHelper().init(),
    GoogleFonts.pendingFonts([
      GoogleFonts.inter(),
    ]),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
  ]);

  showOnBoarding = CacheHelper().getData(key: 'first_time_run');
  CacheHelper().saveData(key: 'first_time_run', value: true);

  //? Load the google fonts to solve the loading bug.
  GoogleFonts.config.allowRuntimeFetching = false;

  //? Adding a font license in the application.
  LicenseRegistry.addLicense(
    () async* {
      final license = await rootBundle.loadString('assets/fonts/inter/OFL.txt');
      yield LicenseEntryWithLineBreaks(
        ['assets/fonts/inter'],
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
