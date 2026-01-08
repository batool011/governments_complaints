import 'package:dio/dio.dart';

class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, {this.statusCode});

  /// Factory for handling Dio errors & HTTP codes
  factory AppException.fromDioError(DioError error) {
    if (error.type == DioErrorType.connectionTimeout ||
        error.type == DioErrorType.receiveTimeout ||
        error.type == DioErrorType.sendTimeout) {
      return AppException("Connection timed out. Please try again.");
    }

    if (error.type == DioErrorType.badResponse) {
      final statusCode = error.response?.statusCode;
      final data = error.response?.data;

      // Use message field from backend if available
      final message =
          data?['message'] ?? data?['error'] ?? "Unexpected server response";

      return AppException(
        _mapStatusCodeToMessage(statusCode, message),
        statusCode: statusCode,
      );
    }

    if (error.type == DioErrorType.cancel) {
      return AppException("Request to server was cancelled");
    }

    if (error.type == DioErrorType.badCertificate) {
      return AppException("Invalid SSL certificate detected");
    }

    // Unknown or network issues
    return AppException("An unexpected error occurred");
  }

  /// Custom helper to map HTTP status codes to friendly text
  static String _mapStatusCodeToMessage(int? statusCode, String message) {
    switch (statusCode) {
      case 400:
        return "Bad request. Please check your input.";
      case 401:
        return  message;
      case 403:
        return "You don’t have permission to perform this action.";
      case 404:
        return "The requested resource was not found.";
      case 408:
        return "Request timeout. Please try again.";
      case 409:
        return "Conflict detected. Please check and retry.";
      case 429:
        return "$message";
      case 422:
        return "$message";
      case 500:
        return "Internal server error. Please try again later.";
      default:
        return "Unexpected error (${statusCode ?? 'unknown'}): $message";
    }
  }

  @override
  String toString() => "$statusCode: $message";
}
