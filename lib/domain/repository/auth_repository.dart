import 'package:anime_academy/ani_config.dart';
import 'package:anime_academy/core/entity/user.dart';
import 'package:anime_academy/data/auth/auth_models.dart';
import 'package:anime_academy/data/auth_store_result.dart';
import 'package:anime_academy/data/http_client.dart';
import 'package:anime_academy/data/token_data.dart';
import 'package:anime_academy/domain/repository/auth_store_repository.dart';
import 'package:anime_academy/services/app_state_storage.dart';

/// Репозиторий для авторизации и регистрации
class AuthRepository {
  final HttpClient _httpClient;
  final AuthStoreRepository _authStoreRepository;
  final AppStateStorage _appStateStorage;

  AuthRepository({
    required HttpClient httpClient,
    required AuthStoreRepository authStoreRepository,
    required AppStateStorage appStateStorage,
  })  : _httpClient = httpClient,
        _authStoreRepository = authStoreRepository,
        _appStateStorage = appStateStorage;

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
      
      // Сохраняем пользователя в AppState
      await _saveUserToAppState(authResponse.user);
      
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
      
      // Сохраняем пользователя в AppState
      await _saveUserToAppState(authResponse.user);
      
      return authResponse.user;
    } catch (e) {
      print('Ошибка при авторизации: $e');
      rethrow;
    }
  }

  /// Выход из аккаунта
  Future<void> logout() async {
    await _authStoreRepository.setToken(null);
    
    // Удаляем пользователя из AppState
    await _saveUserToAppState(User.empty());
  }

  /// Проверка авторизации пользователя
  Future<bool> isAuthenticated() async {
    final result = await _authStoreRepository.getToken();
    return result is AuthStoreResultSuccess && (result as AuthStoreResultSuccess).data != null;
  }
  
  /// Получение данных текущего пользователя
  Future<User?> getCurrentUser() async {
    try {
      final response = await _httpClient.get(
        '/users/me',
        responseParser: (response) => response,
      );
      
      // Проверяем наличие данных в ответе
      if (response.parsedData == null) {
        return null;
      }
      
      final user = User.fromJson(response.parsedData as Map<String, dynamic>);
      
      // Сохраняем обновленные данные пользователя в AppState
      await _saveUserToAppState(user);
      
      return user;
    } catch (e) {
      print('Ошибка при получении данных пользователя: $e');
      return null;
    }
  }
  
  /// Вспомогательный метод для сохранения пользователя в AppState
  Future<void> _saveUserToAppState(User user) async {
    try {
      // Загружаем текущее состояние
      final currentState = await _appStateStorage.loadAppState();
      
      // Создаем новое состояние с обновленным пользователем
      final newState = currentState.copyWith(
        user: user.id == 0 ? null : user, // Если id=0, считаем пользователя пустым
      );
      
      // Сохраняем новое состояние
      await _appStateStorage.saveAppState(newState);
    } catch (e) {
      print('Ошибка при сохранении пользователя в AppState: $e');
    }
  }
} 