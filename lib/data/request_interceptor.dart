import 'dart:async';

import 'package:anime_academy/data/token_data.dart';
import 'package:dio/dio.dart';

class RequestInterceptor extends Interceptor {
  RequestInterceptor({
    required this.onReadToken,
  });

  final FutureOr<TokenData?> Function() onReadToken;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final tokens = await onReadToken();

    // if (tokens != null) {
    //   // options.headers['Authorization'] = 'Bearer ${tokens.accessToken}';
    //   options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';
    // }
    if (tokens != null) {
      options.headers['Authorization'] = 'Bearer ${tokens.accessToken}';
      options.queryParameters['populate'] = '*';
    }
    options.headers[Headers.acceptHeader] = 'application/json';

    handler.next(options);
  }
}
