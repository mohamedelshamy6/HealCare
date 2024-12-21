import 'package:dio/dio.dart';

import '../models/error_model.dart';
import 'api_exception.dart';

class ExceptionHelperMethods {
  ExceptionHelperMethods._();

  static handleDioExceptionsTypes(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throwApiException(noInternetErrorMessage);
      case DioExceptionType.sendTimeout:
        throwApiException(noInternetErrorMessage);
      case DioExceptionType.receiveTimeout:
        throwApiException(noInternetErrorMessage);
      case DioExceptionType.badCertificate:
        throwApiException(connectionErrorMessage);
      case DioExceptionType.cancel:
        throwApiException(connectionErrorMessage);
      case DioExceptionType.unknown:
        throwApiException(connectionErrorMessage);
      case DioExceptionType.badResponse:
        badResponseErrorHandle(e);
      case DioExceptionType.connectionError:
        throwApiException(noInternetErrorMessage);
    }
  }

  static void badResponseErrorHandle(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        badResponseExceptionThrow(e);
      case 401:
        badResponseExceptionThrow(e);
      case 403:
        badResponseExceptionThrow(e);
      case 404:
        badResponseExceptionThrow(e);
      case 409:
        badResponseExceptionThrow(e);
      case 413:
        throw ApiException(
          errorModel:
              ErrorModel.fromJson({'message': 'Request Entity Too Large'}),
        );
      case 422:
        badResponseExceptionThrow(e);
      case 502:
        badResponseExceptionThrow(e);
      case 504:
        badResponseExceptionThrow(e);
      case 302:
        badResponseExceptionThrow(e);
      default:
        badResponseExceptionThrow(e);
    }
  }

  static void badResponseExceptionThrow(DioException e) {
    if (e.response != null || e.response!.data != null) {
      if (e.response!.data is String) {
        throw ApiException(
          errorModel: ErrorModel.fromJson({'message': '${e.response!.data}'}),
        );
      } else if (e.response!.data is Map<String, dynamic>) {
        throw ApiException(
          errorModel: ErrorModel.fromJson(e.response!.data),
        );
      } else {
        throwApiException(connectionErrorMessage);
      }
    } else {
      throwApiException(connectionErrorMessage);
    }
  }

  static void throwApiException(Map<String, dynamic> error) {
    throw ApiException(
      errorModel: ErrorModel.fromJson(error),
    );
  }

  static Map<String, dynamic> get connectionErrorMessage =>
      {'message': 'Try Again Later'};

  static Map<String, dynamic> get noInternetErrorMessage =>
      {'message': 'No Internet Connection'};
}
