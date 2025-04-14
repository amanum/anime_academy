part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

/// Начальное состояние
class AuthInitial extends AuthState {}

/// Состояние загрузки
class AuthLoading extends AuthState {}

/// Состояние успешной авторизации
class AuthSuccess extends AuthState {
  final User? user;

  const AuthSuccess({this.user});
  
  @override
  List<Object?> get props => [user];
}

/// Состояние отсутствия авторизации
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Состояние ошибки
class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});
  
  @override
  List<Object> get props => [message];
} 