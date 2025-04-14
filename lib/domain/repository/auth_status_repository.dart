import 'package:anime_academy/data/auth_status_result.dart';
import 'package:anime_academy/domain/data_source/auth_data_source.dart';

abstract class AuthStatusRepository {
  /// {@macro auth_status_repository}
  factory AuthStatusRepository.createInstance({
    required AuthDataSource authDataSource,
  }) =>
      AuthStatusRepositoryImpl(
        authDataSource: authDataSource,
      );

  /// Logout.
  Future<AuthStatusResult<void>> logout({required String refreshToken});
}

/// {@macro auth_status_repository}
class AuthStatusRepositoryImpl implements AuthStatusRepository {
  /// {@macro auth_status_repository}
  const AuthStatusRepositoryImpl({
    required AuthDataSource authDataSource,
  }) : _authDataSource = authDataSource;

  final AuthDataSource _authDataSource;

  @override
  Future<AuthStatusResult<void>> logout({required String refreshToken}) async {
    try {
      await _authDataSource.logout(refreshToken: refreshToken);
      return const AuthStatusResult$Success();
    } catch (error, stackTrace) {
      return AuthStatusResult$LogoutFailure(error, stackTrace);
    }
  }
}