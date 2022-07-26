class TokenSettings {
  String message;
  String createdAt;
  String expiresAt;
  String accessToken;
  String refreshToken;

  TokenSettings(
    this.message,
    this.createdAt,
    this.expiresAt,
    this.accessToken,
    this.refreshToken,
  );
  factory TokenSettings.fromJson(dynamic json) {
    return TokenSettings(
      json['message'] as String,
      json['createdAt'] as String,
      json['expiresAt'] as String,
      json['accessToken'] as String,
      json['refreshToken'] as String,
    );
  }
}
