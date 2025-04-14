/// Модель пользователя
class User {
  final int id;
  final String username;
  final String email;
  final String? provider;
  final bool confirmed;
  final bool blocked;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    required this.id,
    required this.username,
    required this.email,
    this.provider,
    this.confirmed = false,
    this.blocked = false,
    this.createdAt,
    this.updatedAt,
  });

  /// Создает пустого пользователя
  factory User.empty() {
    return const User(
      id: 0,
      username: '',
      email: '',
      provider: null,
      confirmed: false,
      blocked: false,
    );
  }

  /// Создает экземпляр из JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      provider: json['provider'] as String?,
      confirmed: json['confirmed'] as bool? ?? false,
      blocked: json['blocked'] as bool? ?? false,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
    );
  }

  /// Конвертирует пользователя в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'provider': provider,
      'confirmed': confirmed,
      'blocked': blocked,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          email == other.email;

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ email.hashCode;
}
