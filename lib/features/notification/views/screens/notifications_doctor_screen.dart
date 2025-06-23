import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/helpers/user_cache_helper.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/features/notification/cubit/notification_cubit.dart';
import 'package:heal_care/features/notification/views/widgets/notification_shimmer.dart';
import 'package:heal_care/features/notification/views/widgets/notifications_list.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';

class NotificationsDoctorScreen extends StatefulWidget {
  const NotificationsDoctorScreen({super.key});

  @override
  State<NotificationsDoctorScreen> createState() =>
      _NotificationsDoctorScreenState();
}

class _NotificationsDoctorScreenState extends State<NotificationsDoctorScreen> {
  DoctorsModel? _cachedDoctor;

  @override
  void initState() {
    super.initState();
    _fetchDoctorAndNotifications();
  }

  Future<void> _fetchDoctorAndNotifications() async {
    final doctor = await UserCacheHelper.getCachedDoctorData();
    if (doctor != null) {
      setState(() {
        _cachedDoctor = doctor;
      });

      context.read<NotificationCubit>().fetchNotificationsforDoctors(
            '${AppConstants.baseRestUrl}rpc/get_unread_notifications',
            doctor.id,
          );
    }
  }

  void _markAllAsSeen() {
    if (_cachedDoctor != null) {
      context.read<NotificationCubit>().seenNotification(
            '${AppConstants.baseRestUrl}rpc/mark_notifications_as_read',
            _cachedDoctor!.id,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: FutureBuilder<DoctorsModel?>(
            future: UserCacheHelper.getCachedDoctorData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('No doctor data found.'));
              }

              final doctor = snapshot.data!;
              _cachedDoctor = doctor; // Ensure seenAll works

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppHeader(
                    canBack: true,
                    title: 'Notifications',
                    seenAll: true,
                    onSeenAllTap: _markAllAsSeen,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
