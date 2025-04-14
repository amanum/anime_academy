part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  const AuthEvent();
  
  @override
  List<Object?> get props => [];
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
  
  @override
  List<Object> get props => [identifier, password];
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
  
  @override
  List<Object> get props => [username, email, password];
}

/// Событие для выхода из аккаунта
class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
} 