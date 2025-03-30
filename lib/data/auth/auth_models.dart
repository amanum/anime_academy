import 'package:anime_academy/core/entity/user.dart';

/// Класс для запроса регистрации
class RegisterRequest {
  final String username;
  final String email;
  final String password;

  const RegisterRequest({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'password': password,
      };
}

/// Класс для запроса авторизации
class LoginRequest {
  final String identifier;
  final String password;

  const LoginRequest({
    required this.identifier,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'identifier': identifier,
        'password': password,
      };
}

/// Класс для ответа на запрос авторизации/регистрации
class AuthResponse {
  final String jwt;
  final User user;

  const AuthResponse({
    required this.jwt,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      jwt: json['jwt'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
