part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

/// Начальное состояние
class AuthInitial extends AuthState {}

/// Состояние загрузки
class AuthLoading extends AuthState {}

/// Состояние успешной авторизации
class AuthSuccess extends AuthState {
  final User? user;

  const AuthSuccess({this.user});
}

/// Состояние отсутствия авторизации
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Состояние ошибки
class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});
} 