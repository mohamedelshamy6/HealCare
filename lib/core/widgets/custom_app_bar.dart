import '../theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final VoidCallback? actionsOnPressed;
  final double? leadingWidth;
  final List<Widget>? actionsWidgets;
  final Color? backgroundColor;
  final double? toolbarHeight;

  const CustomAppBar({
    this.title,
    super.key,
    this.leading,
    this.actionsOnPressed,
    this.leadingWidth,
    this.actionsWidgets,
    this.backgroundColor,
    this.toolbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.mainWhite,
      shadowColor: Colors.transparent,
      surfaceTintColor: AppColors.mainWhite,
      elevation: 0,
      leading: leading,
      title: Text(
        title ?? '',
        style: AppTextStyles.interBlack(20, FontWeight.w700),
      ),
      centerTitle: true,
      toolbarHeight: toolbarHeight,
      actions: actionsWidgets ??
          [
            Padding(
              padding: EdgeInsets.only(right: 24.w),
              child: InkWell(
                onTap: actionsOnPressed,
                child: SvgPicture.asset(
                 ' Assets.iconsBlackIconsBlackNotification',
                  height: 24.h,
                  width: 24.w,
                ),
              ),
            ),
          ],
      leadingWidth: leadingWidth,
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, toolbarHeight ?? 60.h);
}
