import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/features/auth/logic/cubit/patients_cubit.dart';
import 'package:heal_care/features/notification/cubit/notification_cubit.dart';
import 'package:heal_care/features/notification/views/widgets/notification_shimmer.dart';
import 'package:heal_care/features/notification/views/widgets/notifications_list.dart';

class NotificationsPatientsScreen extends StatelessWidget {
  const NotificationsPatientsScreen({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientsCubit, PatientsState>(
      listener: (context, state) {
        if (state is PatientsSuccess) {
          final doctor =
              context.read<PatientsCubit>().patientsModel.firstOrNull;
          if (doctor != null) {
            context.read<NotificationCubit>().fetchNotificationsforPatient(
                  '${AppConstants.baseRestUrl}rpc/get_unread_notifications',
                  CacheHelper().getData(key: 'patient_Id') ??
                      CacheHelper().getData(key: 'userId'),
                );
          } else {
            debugPrint("No patients found after success");
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
                  canBack: false,
                  title: 'Notifications',
                  seenAll: true,
                  onSeenAllTap: () {
                    context.read<NotificationCubit>().seenNotification(
                        '${AppConstants.baseRestUrl}rpc/mark_notifications_as_read',
                        CacheHelper().getData(key: 'patient_Id') ??
                            CacheHelper().getData(key: 'userId'));
                  },
                ),
                verticalSpace(24),
                Expanded(
                  child: BlocBuilder<NotificationCubit, NotificationState>(
                    builder: (context, state) {
                      if (state is NotificationPatientLoading) {
                        return const NotificationShimmer();
                      } else if (state is NotificationPatientError) {
                        return Center(child: Text(state.error));
                      } else if (state is NotificationPatientSuccess) {
                        final notifications = state.notifications;
                        if (notifications.isEmpty) {
                          return const Center(
                            child: Text("No notifications found yet."),
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
