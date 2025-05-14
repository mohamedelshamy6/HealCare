import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:intl/intl.dart';

class NotificationsList extends StatelessWidget {
  final String body;
  final String time;
  final int index;
  final VoidCallback onTap;

  const NotificationsList({
    super.key,
    required this.body,
    required this.time,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<String> icons = [
      Assets.iconsNotificationCalenderBlue,
      Assets.iconsNotificationCalenderDarkblue,
      Assets.iconsNotificationCalenderOrange
    ];
    List<Color> colors = [
      AppColors.mainColor.withOpacity(0.1),
      const Color(0xffEEEEFB),
      const Color(0xffFFF6F2),
    ];

    final icon = icons[index % icons.length];
    final color = colors[index % colors.length];

    String formatDateTime(String isoDate) {
      try {
        final dateTime = DateTime.parse(isoDate).toLocal();
        final formattedDate = DateFormat('d MMMM yyyy').format(dateTime);
        final formattedTime = DateFormat('hh:mm a').format(dateTime);
        return '$formattedDate • $formattedTime';
      } catch (e) {
        return isoDate;
      }
    }

    if (body.isEmpty || time.isEmpty) {
      return Container();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.r),
          height: 30.h,
          width: 30.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Center(
            child: SvgPicture.asset(icon),
          ),
        ),
        horizontalSpace(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                body,
                style: AppTextStyles.poppinsBlack(
                  13,
                  FontWeight.w400,
                ),
              ),
              verticalSpace(4),
              Text(
                formatDateTime(time),
                style: AppTextStyles.poppinsMainColor(
                  12,
                  FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
