part of 'app_bloc.dart';

/// Состояние приложения, которое хранится глобально
class AppState extends Equatable {
  /// Код текущего языка
  final String languageCode;
  
  /// Выбранная вселенная
  final Universe? selectedUniverse;
  
  /// Данные текущего пользователя
  final User? user;

  const AppState({
    this.languageCode = 'ru',
    this.selectedUniverse,
    this.user,
  });

  /// Создает копию объекта с новыми значениями
  AppState copyWith({
    String? languageCode,
    Universe? selectedUniverse,
    User? user,
    bool resetSelectedUniverse = false,
    bool resetUser = false,
  }) {
    return AppState(
      languageCode: languageCode ?? this.languageCode,
      selectedUniverse: resetSelectedUniverse ? null : selectedUniverse ?? this.selectedUniverse,
      user: resetUser ? null : user ?? this.user,
    );
  }

  /// Конвертирует состояние в JSON
  Map<String, dynamic> toJson() {
    return {
      'languageCode': languageCode,
      'selectedUniverse': selectedUniverse?.toJson(),
      'user': user?.toJson(),
    };
  }

  /// Создает состояние из JSON
  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      languageCode: json['languageCode'] as String? ?? 'ru',
      selectedUniverse: json['selectedUniverse'] != null
          ? Universe.fromJson(json['selectedUniverse'] as Map<String, dynamic>)
          : null,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Начальное состояние приложения
  factory AppState.initial() {
    return const AppState();
  }

  @override
  List<Object?> get props => [languageCode, selectedUniverse, user];
} 