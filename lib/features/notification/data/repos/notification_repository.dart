import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:heal_care/core/errors/api/exceptions/api_exception.dart';
import 'package:heal_care/core/networking/api_services.dart';
import 'package:heal_care/features/notification/data/model/notification_model.dart';

class NotificationRepository {
  final ApiServices apiServices;
  NotificationRepository(this.apiServices);

  Future<Either<String, List<NotificationModel>>> getNotifications(
      String path, Map<String, dynamic> data) async {
    try {
      final response = await apiServices.post(path, data: data);

      if (response is List) {
        final notifications = response
            .map((notification) => NotificationModel.fromJson(notification))
            .toList()
            .cast<NotificationModel>();
        return right(notifications);
      } else {
        log('Unexpected response format: $response');
        return left('Unexpected response format');
      }
    } on ApiException catch (e) {
      return left(e.errorModel.message ?? 'API Error');
    } catch (e) {
      log('Unexpected error: $e');
      return left('An unexpected error occurred');
    }

    
  }

  Future<Either<String, bool>> seenNotification({
    required String path,
    required dynamic body,
  }) async {
    try {
      await apiServices.post(path, data: body);
      return const Right(true);
    } on ApiException catch (e) {
      return Left(e.errorModel.message ?? 'Error in seen Notification');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
