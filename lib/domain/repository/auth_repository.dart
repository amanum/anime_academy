import 'package:anime_academy/ani_config.dart';
import 'package:anime_academy/core/entity/user.dart';
import 'package:anime_academy/data/auth/auth_models.dart';
import 'package:anime_academy/data/auth_store_result.dart';
import 'package:anime_academy/data/http_client.dart';
import 'package:anime_academy/data/token_data.dart';
import 'package:anime_academy/domain/repository/auth_store_repository.dart';

/// Репозиторий для авторизации и регистрации
class AuthRepository {
  final HttpClient _httpClient;
  final AuthStoreRepository _authStoreRepository;

  AuthRepository({
    required HttpClient httpClient,
    required AuthStoreRepository authStoreRepository,
  })  : _httpClient = httpClient,
        _authStoreRepository = authStoreRepository;

  /// Регистрация нового пользователя
  Future<User> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final request = RegisterRequest(
        username: username,
        email: email,
        password: password,
      );

      final response = await _httpClient.post(
        '/auth/local/register',
        data: request.toJson(),
        responseParser: (response) => response,
      );

      final authResponse = AuthResponse.fromJson(response.parsedData);
      
      // Сохраняем токен
      await _authStoreRepository.setToken(
        TokenData(
          accessToken: authResponse.jwt,
          refreshToken: '', // Strapi не предоставляет refresh token
        ),
      );
      
      return authResponse.user;
    } catch (e) {
      print('Ошибка при регистрации: $e');
      rethrow;
    }
  }

  /// Авторизация пользователя
  Future<User> login({
    required String identifier,
    required String password,
  }) async {
    try {
      final request = LoginRequest(
        identifier: identifier,
        password: password,
      );

      final response = await _httpClient.post(
        '/auth/local',
        data: request.toJson(),
        responseParser: (response) => response,
      );

      final authResponse = AuthResponse.fromJson(response.parsedData);
      
      // Сохраняем токен
      await _authStoreRepository.setToken(
        TokenData(
          accessToken: authResponse.jwt,
          refreshToken: '', // Strapi не предоставляет refresh token
        ),
      );
      
      return authResponse.user;
    } catch (e) {
      print('Ошибка при авторизации: $e');
      rethrow;
    }
  }

  /// Выход из аккаунта
  Future<void> logout() async {
    await _authStoreRepository.setToken(null);
  }

  /// Проверка авторизации пользователя
  Future<bool> isAuthenticated() async {
    final result = await _authStoreRepository.getToken();
    return result is AuthStoreResultSuccess && (result as AuthStoreResultSuccess).data != null;
  }
} 