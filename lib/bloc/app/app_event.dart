part of 'app_bloc.dart';

/// Базовый класс для всех событий AppBloc
sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

/// Событие загрузки начального состояния приложения из хранилища
class AppLoadEvent extends AppEvent {
  const AppLoadEvent();
}

/// Событие изменения языка приложения
class AppChangeLanguageEvent extends AppEvent {
  final String languageCode;

  const AppChangeLanguageEvent({required this.languageCode});

  @override
  List<Object> get props => [languageCode];
}

/// Событие выбора вселенной
class AppSelectUniverseEvent extends AppEvent {
  final Universe universe;

  const AppSelectUniverseEvent({required this.universe});

  @override
  List<Object> get props => [universe];
}

/// Событие сброса выбранной вселенной
class AppResetUniverseEvent extends AppEvent {
  const AppResetUniverseEvent();
}

/// Событие запроса обновления данных пользователя с сервера
class AppUpdateUserEvent extends AppEvent {
  const AppUpdateUserEvent();
} 