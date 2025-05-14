import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:heal_care/core/errors/api/exceptions/api_exception.dart';
import 'package:heal_care/core/networking/api_services.dart';
import 'package:heal_care/features/doctor_home/data/models/notification_model.dart';

class NotificationRepository {
  final ApiServices apiServices;
  NotificationRepository(this.apiServices);

  Future<Either<String, List<NotificationModel>>> getNotifications(
      String path, dynamic data) async {
    try {
      final response = await apiServices.post(path, data: data);
      var notifications = (response as List)
          .map((notification) => NotificationModel.fromJson(notification))
          .toList();
      return right(notifications);
    } on ApiException catch (e) {
      log(e.errorModel.message!);
      return left(e.errorModel.message!);
    } catch (e) {
      log(e.toString());
      return left('An unexpected error occurred');
    }
  }
}
