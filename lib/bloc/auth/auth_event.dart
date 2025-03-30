part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

/// Событие для проверки состояния авторизации
class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

/// Событие для авторизации
class AuthLoginRequested extends AuthEvent {
  final String identifier;
  final String password;

  const AuthLoginRequested({
    required this.identifier,
    required this.password,
  });
}

/// Событие для регистрации
class AuthRegisterRequested extends AuthEvent {
  final String username;
  final String email;
  final String password;

  const AuthRegisterRequested({
    required this.username,
    required this.email,
    required this.password,
  });
}

/// Событие для выхода из аккаунта
class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
} 