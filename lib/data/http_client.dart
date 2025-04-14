import 'package:anime_academy/data/api_error.dart';
import 'package:anime_academy/data/default_error.dart';
import 'package:anime_academy/data/error_type.dart';
import 'package:anime_academy/data/refresh_token_interceptor.dart';
import 'package:anime_academy/data/refresh_token_mixin.dart';
import 'package:anime_academy/data/request_interceptor.dart';
import 'package:anime_academy/data/response_data.dart';
import 'package:anime_academy/data/token_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

typedef JsonMap = Map<String, Object?>;

typedef OnReadToken = Future<TokenData?> Function();
typedef OnSaveToken = Future<void> Function(TokenData?);

class HttpClient with RefreshTokenMixin {
  late Dio _dio;

  ///Клиент для авторизации и http-запросов.
  ///
  ///[onReadToken] Должен возвращать access token и refresh token из хранилища.
  ///
  ///[onSaveToken] Должен сохранять access token и refresh token в хранилище.
  HttpClient({
    String baseUrl = '',
    required OnReadToken onReadToken,
    required OnSaveToken onSaveToken,
    Duration timeout = const Duration(seconds: 15),
  })  : _baseUrl = baseUrl,
        _onReadToken = onReadToken,
        _onSaveToken = onSaveToken {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: timeout,
      connectTimeout: timeout,
    ));
    _dio.interceptors.addAll(
      [
        RequestInterceptor(
          onReadToken: onReadToken,
        ),
        RefreshTokenInterceptor(
          client: this,
          baseUrl: baseUrl,
          onReadToken: onReadToken,
          onSaveToken: onSaveToken,
        ),
        LogInterceptor(
          request: false,
          requestHeader: false,
          responseHeader: false,
        ),
      ],
    );
  }

  final String _baseUrl;
  final OnReadToken _onReadToken;
  final OnSaveToken _onSaveToken;

  /// Http GET запрос.
  Future<ResponseData<T>> get<T>(
    String path, {
    required T Function(JsonMap response) responseParser,
    Object? data,
    JsonMap? queryParameters,
    Options? options,
  }) =>
      _requestApi(
        path,
        method: 'GET',
        responseParser: responseParser,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

  /// Http POST запрос.
  Future<ResponseData<T>> post<T>(
    String path, {
    required T Function(JsonMap response) responseParser,
    Object? data,
    JsonMap? queryParameters,
    Options? options,
  }) =>
      _requestApi(
        path,
        method: 'POST',
        responseParser: responseParser,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

  /// Http PUT запрос.
  Future<ResponseData<T>> put<T>(
    String path, {
    required T Function(JsonMap response) responseParser,
    Object? data,
    JsonMap? queryParameters,
    Options? options,
  }) =>
      _requestApi(
        path,
        method: 'PUT',
        responseParser: responseParser,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

  /// Http DELETE запрос.
  Future<ResponseData<T>> delete<T>(
    String path, {
    required T Function(JsonMap response) responseParser,
    Object? data,
    JsonMap? queryParameters,
    Options? options,
  }) =>
      _requestApi(
        path,
        method: 'DELETE',
        responseParser: responseParser,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

  Future<ResponseData<T>> _requestApi<T>(
    String path, {
    required String method,
    required T Function(JsonMap response) responseParser,
    Object? data,
    JsonMap? queryParameters,
    Options? options,
  }) async {
    try {
      final opt = options?.copyWith(method: method) ?? Options(method: method);
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: opt,
      );

      T result = responseParser(response.data as JsonMap);
      return ResponseData(
        response: response,
        parsedData: result,
      );
    } on DioException catch (e, st) {
      throw ApiError(
        type: e.type.fromDioExceptionType(),
        message: e.message ?? e.toString(),
        stackTrace: st,
        statusCode: e.response?.statusCode,
        data: e.response?.data,
      );
    } catch (e, st) {
      throw DefaultError(
        data: e.toString(),
        stackTrace: st,
      );
    }
  }

  Future<Response<dynamic>> request(
    String path, {
    Object? data,
    JsonMap? queryParameters,
    Options? options,
  }) =>
      _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

  Future<TokenData?> refreshToken() async {
    try {
      final tokenData = await refreshTokenRequest(
        onReadToken: _onReadToken,
        onSaveToken: _onSaveToken,
        baseUrl: _baseUrl,
      );
      await _onSaveToken(tokenData);
      return tokenData;
    } catch (e) {
      await _onSaveToken(null);
      return null;
    }
  }
}
