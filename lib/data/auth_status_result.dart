sealed class AuthStatusResult<T> {
  const AuthStatusResult();
}

final class AuthStatusResult$Success<T> extends AuthStatusResult<T> {
  const AuthStatusResult$Success({this.data});

  final T? data;
}

final class AuthStatusResult$LogoutFailure<T> extends AuthStatusResult<T> {
  const AuthStatusResult$LogoutFailure(
      this.error, [
        this.stackTrace,
      ]);

  final Object error;

  final StackTrace? stackTrace;
}
