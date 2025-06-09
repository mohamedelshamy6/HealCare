import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/notification/cubit/notification_cubit.dart';
import 'package:heal_care/features/notification/views/widgets/notification_shimmer.dart';
import 'package:heal_care/features/notification/views/widgets/notifications_list.dart';

class NotificationsDoctorScreen extends StatelessWidget {
  const NotificationsDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorsCubit, DoctorsState>(
      listener: (context, state) {
        if (state is DoctorsSuccess) {
          final doctor = context.read<DoctorsCubit>().doctorsModel.firstOrNull;
          if (doctor != null) {
            context.read<NotificationCubit>().fetchNotificationsforDoctors(
                  '${AppConstants.baseRestUrl}rpc/get_unread_notifications',
                  context.read<DoctorsCubit>().doctorsModel.first.id,
                );
          } else {
            debugPrint("No doctor found after success");
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppHeader(
                  canBack: true,
                  title: 'Notifications',
                  seenAll: true,
                  onSeenAllTap: () {
                    context.read<NotificationCubit>().seenNotificationforDoctors(
                        '${AppConstants.baseRestUrl}rpc/mark_notifications_as_read',
                        context.read<DoctorsCubit>().doctorsModel.first.id);
                  },
                ),
                verticalSpace(24),
                Expanded(
                  child: BlocBuilder<NotificationCubit, NotificationState>(
                    builder: (context, state) {
                      if (state is NotificationDoctorLoading) {
                        return const NotificationShimmer();
                      } else if (state is NotificationDoctorError) {
                        return Center(child: Text(state.error));
                      } else if (state is NotificationDoctorSuccess) {
                        final notifications = state.notifications;
                        if (notifications.isEmpty) {
                          return const Center(
                            child: Text("No notifications found"),
                          );
                        }
                        final validNotifications = notifications
                            .where((n) =>
                                n.message?.isNotEmpty == true &&
                                n.createdAt != null)
                            .toList();
                        return ListView.separated(
                          itemCount: validNotifications.length,
                          separatorBuilder: (_, __) => Divider(
                            height: 25.h,
                            color: AppColors.mainColor.withOpacity(.5),
                          ),
                          itemBuilder: (context, index) {
                            final notification = validNotifications[index];
                            return NotificationsList(
                              body: notification.message ?? '',
                              time: notification.createdAt?.toString() ?? '',
                              index: index,
                              onTap: () {},
                            );
                          },
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
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
