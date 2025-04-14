import 'package:anime_academy/core/entity/universe.dart';
import 'package:anime_academy/core/entity/user.dart';
import 'package:anime_academy/domain/repository/auth_repository.dart';
import 'package:anime_academy/services/app_state_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

/// Блок для управления глобальным состоянием приложения
class AppBloc extends Bloc<AppEvent, AppState> {
  final AppStateStorage _storage;
  final AuthRepository _authRepository;

  AppBloc({
    required AppStateStorage storage,
    required AuthRepository authRepository,
  }) : _storage = storage,
       _authRepository = authRepository,
       super(AppState.initial()) {
    on<AppLoadEvent>(_onAppLoad);
    on<AppChangeLanguageEvent>(_onChangeLanguage);
    on<AppSelectUniverseEvent>(_onSelectUniverse);
    on<AppResetUniverseEvent>(_onResetUniverse);
    on<AppUpdateUserEvent>(_onUpdateUser);
  }

  /// Загружает состояние приложения из хранилища
  Future<void> _onAppLoad(
    AppLoadEvent event,
    Emitter<AppState> emit,
  ) async {
    try {
      final state = await _storage.loadAppState();
      emit(state);
      
      // После загрузки состояния из хранилища запрашиваем обновленные данные пользователя
      if (state.user != null) {
        add(const AppUpdateUserEvent());
      }
    } catch (e) {
      print('Ошибка при загрузке состояния приложения: $e');
      // В случае ошибки используем начальное состояние
      emit(AppState.initial());
    }
  }

  /// Обрабатывает изменение языка
  Future<void> _onChangeLanguage(
    AppChangeLanguageEvent event,
    Emitter<AppState> emit,
  ) async {
    try {
      final newState = state.copyWith(languageCode: event.languageCode);
      emit(newState);
      await _storage.saveAppState(newState);
    } catch (e) {
      print('Ошибка при изменении языка: $e');
    }
  }

  /// Обрабатывает выбор вселенной
  Future<void> _onSelectUniverse(
    AppSelectUniverseEvent event,
    Emitter<AppState> emit,
  ) async {
    try {
      final newState = state.copyWith(selectedUniverse: event.universe);
      emit(newState);
      await _storage.saveAppState(newState);
    } catch (e) {
      print('Ошибка при выборе вселенной: $e');
    }
  }

  /// Обрабатывает сброс выбранной вселенной
  Future<void> _onResetUniverse(
    AppResetUniverseEvent event,
    Emitter<AppState> emit,
  ) async {
    try {
      final newState = state.copyWith(resetSelectedUniverse: true);
      emit(newState);
      await _storage.saveAppState(newState);
    } catch (e) {
      print('Ошибка при сбросе вселенной: $e');
    }
  }
  
  /// Обновляет данные пользователя с сервера
  Future<void> _onUpdateUser(
    AppUpdateUserEvent event,
    Emitter<AppState> emit,
  ) async {
    try {
      // Запрашиваем обновленные данные пользователя с сервера
      // Репозиторий сам сохранит их в хранилище
      await _authRepository.getCurrentUser();
      
      // Загружаем обновленное состояние из хранилища
      final updatedState = await _storage.loadAppState();
      emit(updatedState);
    } catch (e) {
      print('Ошибка при обновлении пользователя: $e');
    }
  }
} 