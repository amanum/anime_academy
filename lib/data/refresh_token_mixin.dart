
import 'package:anime_academy/data/http_client.dart';
import 'package:anime_academy/data/token_data.dart';

mixin RefreshTokenMixin {
  Future<TokenData?> refreshTokenRequest({
    required OnReadToken onReadToken,
    required OnSaveToken onSaveToken,
    required String baseUrl,
  }) async {
    final tokens = await onReadToken();
    if (tokens == null) {
      return null;
    }

    final responseData = await HttpClient(
      baseUrl: baseUrl,
      onReadToken: onReadToken,
      onSaveToken: onSaveToken,
    ).post<TokenData?>(
      '/auth/v1/refresh',
      data: <String, Object>{
        "refresh_token": tokens.refreshToken,
      },
      responseParser: TokenData.fromJson,
    );

    return responseData.parsedData;
  }
}
