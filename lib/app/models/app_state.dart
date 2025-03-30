import 'package:anime_academy/constants/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// {@template app_state}
/// Модель для хранения состояния приложения (локализация, тема).
/// {@endtemplate}
class AppState extends Equatable {
  /// {@macro app_state}
  const AppState({
    required this.locale,
    this.themeMode = ThemeMode.system,
    this.theme,
  });

  /// Generate Class from Map<String, Object?>.
  factory AppState.fromJson(Map<String, Object?> json) {
    final lang = json['locale'] == null
        ? <String>[]
        : (json['locale']! as String).split('-');
    final langCode = lang.firstOrNull ?? Constants.defaultLanguageCode;
    final countryCode = (lang.length > 1 ? lang.last : null);
    return AppState(
      locale: Locale(langCode, countryCode),
      themeMode: ThemeMode.values.firstWhere(
            (e) => e.name == json['themeMode'] as String?,
        orElse: () => ThemeMode.system,
      ),
    );
  }

  /// Generate Map<String, Object?> from class.
  Map<String, Object?> toJson() {
    return {
      'locale': locale.toLanguageTag(),
      'themeMode': themeMode.name,
      // Пока присваиваем null.
      // Для сохранения ThemeData у нас должен быть список тем с названиями.
      'theme': null,
    };
  }

  /// Создает копию текущего состояния приложения.
  AppState copyWith({
    Locale? locale,
    ThemeMode? themeMode,
    ThemeData? theme,
  }) {
    return AppState(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      theme: theme ?? this.theme,
    );
  }

  /// Текущий язык приложения.
  final Locale locale;

  /// Текущий режим темы приложения.
  final ThemeMode themeMode;

  /// Текущая тема приложения.
  final ThemeData? theme;

  @override
  List<Object?> get props => [locale, themeMode, theme];
}
