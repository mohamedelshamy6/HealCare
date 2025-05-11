import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/theme/app_text_styles.dart';

class FindDoctorsContainer extends StatelessWidget {
  const FindDoctorsContainer({
    super.key, required this.doctorsModel,
  });

  final List<DoctorsModel> doctorsModel;

  @override
  Widget build(BuildContext context) {
    log(doctorsModel.toString());
    return ListView.separated(
      itemCount: doctorsModel.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
                width: 2, color: AppColors.findDoctorsCardBorderColor),
            color: AppColors.findDoctorsCardColor,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18.r,
                    backgroundImage: NetworkImage(
                      doctorsModel[index].image.toString(),
                    ),
                  ),
                  horizontalSpace(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctorsModel[index].name.toString(),
                          style: AppTextStyles.poppinsBlack(
                            14,
                            FontWeight.w600,
                          ),
                        ),
                        verticalSpace(4),
                        Text(
                          doctorsModel[index].specialization.toString(),
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
                      index % 2 == 0
                          ? Assets.iconsFavoriteIconRedOutlined
                          : Assets.iconsFavoriteIconRed,
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
                    arguments: doctorsModel[index],
                  );
                },
                textStyle: AppTextStyles.poppinsMainColor(14, FontWeight.w600),
                color: AppColors.findDoctorsCardButtonColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
