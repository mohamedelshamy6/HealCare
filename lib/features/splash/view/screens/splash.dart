import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController flipAnimationController;
  late Animation<double> flipAnimation;
  @override
  void initState() {
    super.initState();
    myFlipAnimation();
  }

  void myFlipAnimation() {
    flipAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward().whenComplete(
        () => Timer(
          const Duration(seconds: 2),
          () => Navigator.pushNamedAndRemoveUntil(
              context, Routes.choose, (route) => false),
        ),
      );
    flipAnimation = Tween<double>(
      begin: 0,
      end: 4,
    ).animate(
      CurvedAnimation(
          parent: flipAnimationController, curve: Curves.easeInQuad),
    );
  }

  @override
  void dispose() {
    flipAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 125.h,
              bottom: 0.h,
              left: -160.w,
              right: -300.w,
              child: Image.asset(
                Assets.imagesSplashGradient,
              ),
            ),
            AnimatedBuilder(
              animation: flipAnimation,
              builder: (context, child) => Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(flipAnimation.value * 3.14),
                child: Image.asset(
                  flipAnimation.value % 2 < 1
                      ? Assets.imagesSplashSplashImage2
                      : Assets.imagesSplashSplashImage1,
                  width: 115.w,
                  height: 115.h,
                ),
              ),
            ),
            verticalSpace(24.h),
            Positioned(
              top: 480.h,
              bottom: 260.h,
              child: Text(
                'HealCare',
                style: AppTextStyles.poppinsMainColor(40, FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
