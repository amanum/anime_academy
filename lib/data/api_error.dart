import 'package:anime_academy/data/error_type.dart';

class ApiError implements Exception {
  const ApiError({
    required this.message,
    this.statusCode,
    this.data,
    this.stackTrace,
    this.parentError,
    this.type,
  });

  final int? statusCode;
  final String message;
  final Object? data;
  final Object? stackTrace;
  final Object? parentError;
  final ErrorType? type;

  @override
  String toString() =>
      'ApiError:\nstatusCode=${statusCode ?? -1}\nmessage="$message"';
}
