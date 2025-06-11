import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/patient_favorite/views/widgets/patient_favorites_card.dart';
import 'package:heal_care/core/routing/routes.dart';

class PatientFavoritesScreen extends StatefulWidget {
  const PatientFavoritesScreen({super.key});

  @override
  State<PatientFavoritesScreen> createState() => _PatientFavoritesScreenState();
}

class _PatientFavoritesScreenState extends State<PatientFavoritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorsCubit>().getPatientFavourites();
  }

  Future<void> _handleBackNavigation() async {
    await context.read<DoctorsCubit>().getAllDoctors();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.patientHome,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _handleBackNavigation();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppHeader(
                  canBack: true,
                  title: 'Favorites',
                  horizSpace: MediaQuery.sizeOf(context).width < 400 ? 56 : 80,
                  onTap: _handleBackNavigation,
                ),
                verticalSpace(24),
                BlocConsumer<DoctorsCubit, DoctorsState>(
                  listener: (context, state) {
                    if (state is PatientToogleFavouritesSuccess) {
                      context.read<DoctorsCubit>().getPatientFavourites();
                    }
                  },
                  buildWhen: (previous, current) {
                    return current is PatientFavouritesLoading ||
                        current is PatientFavouritesSuccess ||
                        current is PatientFavouritesFailure;
                  },
                  builder: (context, state) {
                    if (state is PatientFavouritesLoading) {
                      return const Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (state is PatientFavouritesSuccess) {
                      if (state.patientFavoritesModel.isEmpty) {
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                size: 64.r,
                                color: Colors.grey,
                              ),
                              verticalSpace(16),
                              Text(
                                "No favorites yet",
                                style: AppTextStyles.poppinsBlack(
                                  16,
                                  FontWeight.w500,
                                ),
                              ),
                              verticalSpace(8),
                              Text(
                                "Add doctors to your favorites to see them here",
                                style: AppTextStyles.poppinsGrey(
                                  14,
                                  FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => PatientFavoritesCard(
                            doctors: state.patientFavoritesModel[index],
                          ),
                          separatorBuilder: (context, index) =>
                              verticalSpace(12),
                          itemCount: state.patientFavoritesModel.length,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
