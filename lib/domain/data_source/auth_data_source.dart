import 'package:anime_academy/data/http_client.dart';

class AuthDataSource {
  AuthDataSource({required this.client});

  final HttpClient client;

  /// Logout
  Future<void> logout({required String refreshToken}) async {
    await client.post(
      '/auth/v1/logout',
      data: {
        'refresh_token': refreshToken,
      },
      responseParser: (Map<String, Object?> response) {},
    );
  }
}
