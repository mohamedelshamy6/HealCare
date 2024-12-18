import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../patient_home/data/models/doctors_model.dart';

class PatientFavoritesCard extends StatelessWidget {
  final int index;
  const PatientFavoritesCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border:
            Border.all(width: 2, color: AppColors.findDoctorsCardBorderColor),
        color: AppColors.findDoctorsCardColor,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundImage: AssetImage(
                  doctors[index].image,
                ),
              ),
              horizontalSpace(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctors[index].name,
                      style: AppTextStyles.poppinsBlack(
                        14,
                        FontWeight.w600,
                      ),
                    ),
                    verticalSpace(4),
                    Text(
                      doctors[index].job,
                      style: AppTextStyles.poppinsBlack(
                        14,
                        FontWeight.w400,
                      ).copyWith(color: Color(0xffAAB6C3)),
                    ),
                    verticalSpace(8),
                  ],
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                ),
                onPressed: () {},
                icon: Image.asset(
                  height: 20.h,
                  width: 22.w,
                  Assets.iconsFavoriteIconRed,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  '4.8',
                  style: AppTextStyles.poppinsBlack(
                    14,
                    FontWeight.w500,
                  ),
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
                  '10:30am - 5:30pm',
                  style: AppTextStyles.poppinsBlack(
                    14,
                    FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(16),
          CustomButton(
            buttonText: 'Book Appointment',
            borderRadius: 8,
            buttonAction: () {
              Navigator.of(context).pushNamed(
                Routes.bookDoctorAppointment,
                arguments: doctors[index],
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
