import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/patient_favorites_card.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_app_header.dart';

class PatientFavoritesScreen extends StatelessWidget {
  const PatientFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppHeader(
                  canBack: true,
                  title: 'Favorites',
                  horizSpace: MediaQuery.sizeOf(context).width < 400 ? 56 : 80,
                ),
                verticalSpace(24),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        PatientFavoritesCard(index: index),
                    separatorBuilder: (context, index) => verticalSpace(12),
                    itemCount: 6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
