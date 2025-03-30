import 'dart:convert';

import 'package:anime_academy/app/const/store_keys.dart';
import 'package:anime_academy/app/models/key_value_store.dart';
import 'package:anime_academy/bloc/app/app_bloc.dart';

/// Сервис для работы с хранилищем состояния приложения
class AppStateStorage {
  final KeyValueStore _store;

  AppStateStorage({required KeyValueStore store}) : _store = store;

  /// Сохраняет состояние приложения в хранилище
  Future<void> saveAppState(AppState state) async {
    try {
      final stateJson = jsonEncode(state.toJson());
      await _store.write<String>(StoreKeys.appState, stateJson);
    } catch (e) {
      print('Ошибка при сохранении состояния приложения: $e');
    }
  }

  /// Загружает состояние приложения из хранилища
  Future<AppState> loadAppState() async {
    try {
      final stateJson = await _store.read<String>(StoreKeys.appState);
      if (stateJson == null) {
        return AppState.initial();
      }
      
      final stateMap = jsonDecode(stateJson) as Map<String, dynamic>;
      return AppState.fromJson(stateMap);
    } catch (e) {
      print('Ошибка при загрузке состояния приложения: $e');
      return AppState.initial();
    }
  }

  /// Очищает состояние приложения в хранилище
  Future<void> clearAppState() async {
    try {
      await _store.write<String>(StoreKeys.appState, null);
    } catch (e) {
      print('Ошибка при очистке состояния приложения: $e');
    }
  }
} 