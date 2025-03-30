import 'package:anime_academy/data/http_client.dart';
import 'package:anime_academy/data/refresh_token_mixin.dart';
import 'package:anime_academy/data/token_data.dart';
import 'package:dio/dio.dart';

class RefreshTokenInterceptor extends QueuedInterceptor with RefreshTokenMixin {
  RefreshTokenInterceptor({
    required this.client,
    required this.baseUrl,
    required this.onReadToken,
    required this.onSaveToken,
  });

  final HttpClient client;
  final String baseUrl;
  final OnReadToken onReadToken;
  final OnSaveToken onSaveToken;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final errorResponse = err.response;

    if (errorResponse?.statusCode != 401) {
      return handler.next(err);
    }

    final errData = errorResponse?.data;

    /// если не получилось обновить токен, то удаляем его
    if (errData is Map && errData['error'] == 'refresh_token_error') {
      await onSaveToken(null);
      return;
    } else if (errData == 'Unauthenticated.') {
      await onSaveToken(null);
      return;
    }
    final requestOptions = err.requestOptions;

    final headers = requestOptions.headers;

    try {
      final tokenData = await _onRefreshToken();
      if (tokenData == null) {
        await onSaveToken(null);
        return handler.next(err);
      }
      await onSaveToken(tokenData);
      headers['Authorization'] = 'Bearer ${tokenData.accessToken}';

      final options = Options(
        method: requestOptions.method,
        headers: headers,
      );
      final response = await client.request(
        requestOptions.path,
        options: options,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
      );

      handler.resolve(response);
    } catch (e) {
      await onSaveToken(null);
      return handler.next(err);
    }
  }

  Future<TokenData?> _onRefreshToken() async => refreshTokenRequest(
        onReadToken: onReadToken,
        onSaveToken: onSaveToken,
        baseUrl: baseUrl,
      );
}
