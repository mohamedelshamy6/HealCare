import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/helpers/user_cache_helper.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.date,
    required this.image,
    required this.senderType,
  });

  final String message;
  final String date;
  final String image;
  final String senderType;

  Future<String?> _getCachedImage() async {
    if (senderType.toLowerCase() == 'doctor') {
      final doctor = await UserCacheHelper.getCachedDoctorData();
      return doctor?.image;
      
    } else {
      final patient = await UserCacheHelper.getCachedPatientData();
      return patient?.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: image.isNotEmpty ? Future.value(image) : _getCachedImage(),
      builder: (context, snapshot) {
        final imageUrl = snapshot.data;

        return Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  imageUrl != null && imageUrl.isNotEmpty
                      ? CircleAvatar(
                          radius: 20.r,
                          backgroundImage: NetworkImage(imageUrl),
                          onBackgroundImageError: (exception, stackTrace) {
                            debugPrint('Image load error: $exception');
                          },
                        )
                      : CircleAvatar(
                          radius: 20.r,
                          backgroundColor: AppColors.mainColor.withOpacity(0.1),
                          child: Icon(
                            Icons.person,
                            size: 24.r,
                            color: AppColors.mainColor,
                          ),
                        ),
                  horizontalSpace(8.87),
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 300),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Opacity(
                          opacity: value,
                          child: child,
                        ),
                      );
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width < 400
                                ? 222.w
                                : 270.w,
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 17.h, horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.r),
                              topRight: Radius.circular(30.r),
                              bottomRight: Radius.circular(20.r),
                            ),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            message,
                            style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
                          ),
                        ),
                        Positioned(
                          bottom: -22.h,
                          right: 0,
                          child: Text(
                            date,
                            style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              verticalSpace(24),
            ],
          ),
        );
      },
    );
  }
}
