import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/routing/routes.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_button.dart';
import 'package:heal_care/features/auth/data/models/patient_favourotes_model.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';

class PatientFavoritesCard extends StatelessWidget {
  final PatientFavouritesModel doctors;

  const PatientFavoritesCard({
    super.key,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          width: 2,
          color: AppColors.findDoctorsCardBorderColor,
        ),
        color: AppColors.findDoctorsCardColor,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl: doctors.doctorImage ?? '',
                  width: 60.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.person),
                ),
              ),
              horizontalSpace(12),

              // Doctor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctors.doctorName ?? 'Unknown Doctor',
                      style: AppTextStyles.poppinsBlack(14, FontWeight.w600),
                    ),
                    verticalSpace(4),
                    Text(
                      doctors.specialization ?? 'General',
                      style: AppTextStyles.poppinsBlack(14, FontWeight.w400)
                          .copyWith(color: const Color(0xffAAB6C3)),
                    ),
                    verticalSpace(8),
                  ],
                ),
              ),

              // Favorite icon
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context.read<DoctorsCubit>().removeFromFavourites(doctors);
                },
                icon: Image.asset(
                  Assets.iconsFavoriteIconRed,
                  height: 20.h,
                  width: 22.w,
                ),
              ),
            ],
          ),

          // Rating + Working Time
          Padding(
            padding: EdgeInsets.only(left: 12.w, top: 8.h),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  (doctors.averageRate?.toStringAsFixed(1) ?? '4.8'),
                  style: AppTextStyles.poppinsBlack(14, FontWeight.w500),
                ),
                horizontalSpace(4),
                Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: SvgPicture.asset(
                    Assets.iconsStarIconYellow,
                    height: 15.h,
                    width: 15.w,
                  ),
                ),
                horizontalSpace(24),
                Image.asset(
                  Assets.iconsClockSquareIconGrey,
                  height: 15.h,
                  width: 15.w,
                ),
                horizontalSpace(8),
                Text(
                  '10:30am - 5:30pm', // ممكن تجيبها من `doctors.availableTime` لو كانت موجودة
                  style: AppTextStyles.poppinsBlack(14, FontWeight.w500),
                ),
              ],
            ),
          ),

          verticalSpace(16),

          // Book Appointment Button
          CustomButton(
            buttonText: 'Book Appointment',
            borderRadius: 8,
            buttonAction: () {
              // Convert PatientFavouritesModel to DoctorsModel
              final doctorModel = DoctorsModel(
                id: doctors.doctorId,
                name: doctors.doctorName,
                image: doctors.doctorImage,
                specialization: doctors.specialization,
                isFavourite: true,
              );

              Navigator.of(context).pushNamed(
                Routes.bookDoctorAppointment,
                arguments: doctorModel,
              );
            },
            textStyle: AppTextStyles.poppinsMainColor(14, FontWeight.w600),
            color: AppColors.findDoctorsCardButtonColor,
          ),
        ],
      ),
    );
  }
}
