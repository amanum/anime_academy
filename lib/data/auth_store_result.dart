
sealed class AuthStoreResult<T> {
  const AuthStoreResult();
}

final class AuthStoreResultSuccess<T> extends AuthStoreResult<T> {
  const AuthStoreResultSuccess({this.data});

  final T? data;
}

final class AuthStoreResultFailure<T> extends AuthStoreResult<T> {
  const AuthStoreResultFailure(
      this.error, [
        this.stackTrace,
      ]);

  final Object error;

  final StackTrace? stackTrace;
}
