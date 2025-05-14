import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/notification/cubit/notification_cubit.dart';
import 'package:heal_care/features/notification/views/widgets/notification_shimmer.dart';
import 'package:heal_care/features/notification/views/widgets/notifications_list.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorsCubit, DoctorsState>(
      listener: (context, state) {
        if (state is DoctorsSuccess) {
          final doctor = context.read<DoctorsCubit>().doctorsModel.firstOrNull;
          if (doctor != null) {
            context.read<NotificationCubit>().fetchNotifications(
                  '${AppConstants.baseRestUrl}rpc/get_unread_notifications_for_doctor',
                  doctor.id,
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
                const CustomAppHeader(
                  canBack: true,
                  title: 'Notifications',
                ),
                verticalSpace(24),
                Expanded(
                  child: BlocBuilder<NotificationCubit, NotificationState>(
                    builder: (context, state) {
                      if (state is NotificationLoading) {
                        return const NotificationShimmer();
                      } else if (state is NotificationError) {
                        return Center(child: Text(state.error));
                      } else if (state is NotificationSuccess) {
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
                          separatorBuilder: (_, __) => verticalSpace(16),
                          itemBuilder: (context, index) {
                            return NotificationsList(
                              body: validNotifications[index].message ?? '',
                              time:
                                  validNotifications[index].createdAt?.toString() ??
                                      '',
                              index: index,
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
