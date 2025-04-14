part of 'auth_status_bloc.dart';

@immutable
sealed class AuthStatusEvent {
  const AuthStatusEvent();
}

final class AuthStatusEvent$Init extends AuthStatusEvent {
  const AuthStatusEvent$Init();
}

final class AuthStatusEvent$Set extends AuthStatusEvent {
  const AuthStatusEvent$Set({this.authorized = true});

  final bool authorized;
}

final class AuthStatusEvent$SetToken extends AuthStatusEvent {
  const AuthStatusEvent$SetToken({
    this.token,
  });

  final TokenData? token;
}

final class AuthStatusEvent$RefreshToken extends AuthStatusEvent {
  const AuthStatusEvent$RefreshToken();
}

final class AuthStatusEvent$Logout extends AuthStatusEvent {
  const AuthStatusEvent$Logout();
}
