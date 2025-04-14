import 'package:dio/dio.dart';

enum ErrorType {
  timeout,

  cancel,

  connectionError,

  unknown,
}

extension DlsDioErrorTypeMapper on DioExceptionType {
  ErrorType fromDioExceptionType() {
    return switch (this) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        ErrorType.timeout,
      DioExceptionType.cancel => ErrorType.cancel,
      DioExceptionType.connectionError => ErrorType.connectionError,
      _ => ErrorType.unknown,
    };
  }
}
