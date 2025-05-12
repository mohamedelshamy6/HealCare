// import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../theme/app_colors.dart';
import 'dart:convert';

// import '../widgets/custom_border_button.dart';
// import 'app_images.dart';

// import '../routing/routes.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_border_button.dart';
import '../widgets/custom_button.dart';
import 'app_images.dart';
import 'cache_helper.dart';
// import '../widgets/custom_button.dart';

class HelperMethods {
  HelperMethods._();
  // static Future<dynamic> showNewPasswordSuccessDialog(BuildContext context) {
  //   return showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) => BackdropFilter(
  //       filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
  //       child: PopScope(
  //         canPop: false,
  //         child: AlertDialog.adaptive(
  //           backgroundColor: Colors.white,
  //           surfaceTintColor: Colors.white,
  //           contentPadding: EdgeInsets.zero,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //           content: SizedBox(
  //             height: 400.h,
  //             width: 335.w,
  //             child: Padding(
  //               padding: EdgeInsets.all(16.r),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   SvgPicture.asset(
  //                     Assets.svgsDone,
  //                     height: 120.h,
  //                     width: 120.w,
  //                   ),
  //                   SizedBox(height: 16.h),
  //                   Text(
  //                     'Password Update\nSuccessfully',
  //                     textAlign: TextAlign.center,
  //                     style: AppTextStyles.poppinsBold22Black,
  //                   ),
  //                   SizedBox(height: 8.h),
  //                   Text(
  //                     'Password changed succesfully\nYou can login again with new password',
  //                     textAlign: TextAlign.center,
  //                     style: AppTextStyles.poppinsRegular16SecoondaryBlue,
  //                   ),
  //                   SizedBox(height: 32.h),
  //                   CustomButton(
  //                     buttonText: 'Back to Login',
  //                     buttonAction: () {
  //                       Navigator.pushNamedAndRemoveUntil(
  //                           context, Routes.loginScreen, (route) => false,
  //                           arguments: 'businessLogin');
  //                     },
  //                     buttonStyle: AppTextStyles.poppinsBold15White,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  static void showCustomSnackBarSuccess(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.left,
          style: AppTextStyles.poppinsWhite(15, FontWeight.w600),
        ),
        backgroundColor: AppColors.mainColor,
        duration: const Duration(seconds: 3),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        elevation: 4,
      ),
    );
  }

  static void showCustomSnackBarError(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.left,
          style: AppTextStyles.poppinsWhite(15, FontWeight.w600),
        ),
        backgroundColor: AppColors.tFFErrorColor,
        duration: const Duration(seconds: 3),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        elevation: 4,
      ),
    );
  }

  static Future<Widget?> showLoadingAlertDialog(context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => PopScope(
        canPop: false,
        child: AbsorbPointer(
          absorbing: true,
          child: AlertDialog.adaptive(
            contentPadding: EdgeInsets.zero,
            backgroundColor: AppColors.mainColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: SizedBox(
              height: 200.h,
              width: 100.w,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> refreshAccessToken() async {
    final refreshToken =
        await CacheHelper().getSecuredData(key: 'refreshToken');

    if (refreshToken == null) {
      return;
    }

   

    final response =
        await Supabase.instance.client.auth.refreshSession(refreshToken);

    if (response.session != null) {
      await CacheHelper().saveSecuredData(
          key: 'accessToken', value: response.session!.accessToken);
      await CacheHelper().saveSecuredData(
          key: 'refreshToken', value: response.session!.refreshToken!);
    }
  }

  static Future<void> checkAndRefreshToken() async {
    final accessToken = await CacheHelper().getSecuredData(key: 'accessToken');

    if (accessToken == null) {
      return;
    }

    final isExpired = checkTokenExpiration(accessToken);
    if (isExpired) {
      await refreshAccessToken();
    }
  }

  static bool checkTokenExpiration(String token) {
    final parts = token.split('.');
    if (parts.length != 3) return true;

    final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
    final exp = payload['exp'];
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    return now >= exp;
  }

  static Future onRequset(
      RequestOptions options, RequestInterceptorHandler handler) async {
    await checkAndRefreshToken();
    final accessToken = await CacheHelper().getSecuredData(key: 'accessToken');

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }

  static Future<Widget?> showLogoutAlertDialog(
      context, Function() buttonAction) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        content: SizedBox(
          height: 277.h,
          width: 325.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.svgsLogout,
                  height: 120.h,
                  width: 120.w,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Are you sure you want to logout?',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.poppinsBlack(14, FontWeight.w600),
                ),
                SizedBox(height: 32.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        buttonText: 'Logout',
                        buttonAction: buttonAction,
                        height: 35.h,
                        textStyle:
                            AppTextStyles.poppinsWhite(14, FontWeight.w600),
                        color: Color(0xffF14E2E),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: CustomBorderButton(
                        buttonText: 'Cancel',
                        buttonAction: () {
                          Navigator.pop(context);
                        },
                        height: 30.h,
                        buttonStyle:
                            AppTextStyles.poppinsMainColor(14, FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void svgPrecacheImage() {
    const cacheSvgImages = [];

    for (String element in cacheSvgImages) {
      var loader = SvgAssetLoader(element);
      svg.cache
          .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
  }
}
