final class TokenData {
  final String refreshToken;
  final String accessToken;

  TokenData({
    required this.refreshToken,
    required this.accessToken,
  });

  factory TokenData.fromJson(Map<String, Object?> json) => TokenData(
    refreshToken: json['refresh_token'] as String,
    accessToken: json['access_token'] as String,
  );

  Map<String, dynamic> toJson() {
    return {
      'refresh_token': refreshToken,
      'access_token': accessToken,
    };
  }

  @override
  String toString() {
    return toJson.toString();
  }
}
