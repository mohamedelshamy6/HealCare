import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class DoctorsContainer extends StatelessWidget {
  final DoctorsModel doctorsModel;
  const DoctorsContainer({
    super.key,
    required this.doctorsModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context)
            .pushNamed(Routes.bookDoctorAppointment, arguments: doctorsModel);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.all(12.r),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  width: 64.w,
                  height: 64.h,
                  decoration: BoxDecoration(
                    color: AppColors.mainWhite,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(22.r),
                        bottomRight: Radius.circular(22.r),
                        topLeft: Radius.circular(22.r),
                        topRight: Radius.circular(12.r)),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: doctorsModel.image ?? '',
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 19.r,
                      backgroundImage: imageProvider,
                    ),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.person, size: 24.r),
                  ),
                ),
                Positioned(
                  top: -1.h,
                  right: -1.w,
                  child: CircleAvatar(
                    radius: 6.r,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: CircleAvatar(
                        radius: 4.r,
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            horizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorsModel.name.toString(),
                    style: AppTextStyles.poppinsBlack(
                      16,
                      FontWeight.w500,
                    ),
                  ),
                  verticalSpace(4),
                  Text(
                    doctorsModel.specialization.toString(),
                    style: AppTextStyles.poppinsGrey(
                      10,
                      FontWeight.w400,
                    ),
                  ),
                  verticalSpace(4),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          '10:20 AM - 12:30 PM',
                          style: AppTextStyles.poppinsMainColor(
                            9,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: AppColors.mainColor,
                        radius: 10.r,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 14.r,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
