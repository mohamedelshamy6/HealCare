import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_app_header.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../widgets/notifications_list.dart';

class NotificationsScreen extends StatelessWidget {
  final String type;
  const NotificationsScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppHeader(
                  canBack: type == 'patient' ? false : true,
                  title: 'Notifications',
                  horizSpace: type == 'patient'
                      ? null
                      : MediaQuery.sizeOf(context).width < 400
                          ? 42
                          : 64,
                ),
                verticalSpace(24),
                // ? THIS IS TEMPORARY CODE FOR UI.
                // ? =============================================================
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => index == 2
                        ? SizedBox()
                        : Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Text(
                              index == 0
                                  ? 'Today - 20 Sep, 2020'
                                  : '19 Sep, 2020',
                              style: AppTextStyles.poppinsBlack(
                                  16, FontWeight.w400),
                            ),
                          ),
                    separatorBuilder: (context, index) => NotificationsList(),
                    itemCount: 3,
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
