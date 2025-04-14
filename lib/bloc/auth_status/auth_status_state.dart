part of 'auth_status_bloc.dart';

@immutable
sealed class AuthStatusState {
  const AuthStatusState();
}

final class AuthStatusState$Initial extends AuthStatusState {
  const AuthStatusState$Initial();
}

final class AuthStatusState$Authorized extends AuthStatusState {
  const AuthStatusState$Authorized();
}

final class AuthStatusState$Unauthorized extends AuthStatusState {
  const AuthStatusState$Unauthorized();
}

final class AuthStatusState$ServerConnectionError extends AuthStatusState {
  const AuthStatusState$ServerConnectionError();
}

final class AuthStatusState$LocalStorageError extends AuthStatusState {
  const AuthStatusState$LocalStorageError();
}

final class AuthStatusState$Processing extends AuthStatusState {
  const AuthStatusState$Processing();
}
