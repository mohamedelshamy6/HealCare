import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend(
      {super.key,
      required this.message,
      required this.date,
      required this.type,
      required this.image});
  final String message;
  final String date;
  final String type;
  final String image;
  @override
  Widget build(BuildContext context) {
    final bool isDoctor = type.toLowerCase() == 'doctor';

    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
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
                      padding: EdgeInsets.only(
                          top: 17.h, right: 12.w, bottom: 16.h, left: 17.w),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                          bottomLeft: Radius.circular(20.r),
                        ),
                      ),
                      child: Text(
                        message,
                        style: AppTextStyles.poppinsWhite(14, FontWeight.w400),
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
              horizontalSpace(8),
              image.isNotEmpty
                  ? CircleAvatar(
                      radius: 20.r,
                      backgroundImage: NetworkImage(image),
                      onBackgroundImageError: (exception, stackTrace) {
                        // This will be called if the image fails to load
                      },
                      child: image.endsWith('null') || image.isEmpty
                          ? Icon(
                              Icons.person,
                              size: 24.r,
                              color: AppColors.mainColor,
                            )
                          : null,
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
            ],
          ),
          verticalSpace(24),
        ],
      ),
    );
  }
}
