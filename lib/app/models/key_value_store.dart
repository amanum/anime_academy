import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStore {
  SharedPreferences? _sharedPreferences;
  FlutterSecureStorage? _flutterSecureStorage;

  Future<void> initialize() async {
    _flutterSecureStorage = const FlutterSecureStorage();
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  bool get isInitialized =>
      _sharedPreferences != null && _flutterSecureStorage != null;

  Future<T?> read<T>(StoreKey<T> typedStoreKey) async {
    if (_sharedPreferences == null || _flutterSecureStorage == null) {
      // coverage:ignore-start
      throw Exception('KeyValueStore not initialized');
      // coverage:ignore-end
    }
    if (!typedStoreKey.secure) {
      return _sharedPreferences?.get(typedStoreKey.key) as T?;
    }

    final value = await _flutterSecureStorage?.read(key: typedStoreKey.key);

    if (value == null) {
      return null;
    }

    switch (T) {
      case const (int):
        return int.parse(value) as T;
      case const (String):
        return value as T;
      case const (double):
        return double.parse(value) as T;
      case const (bool):
        return bool.parse(value) as T;
      case const (List):
        return jsonDecode(value) as T;
    }
    return null;
  }

  Future<void> write<T>(StoreKey<T> typedStoreKey, T? value) async {
    if (_sharedPreferences == null || _flutterSecureStorage == null) {
      // coverage:ignore-start
      throw Exception('KeyValueStore not initialized');
      // coverage:ignore-end
    }

    /// удаление
    if (value == null) {
      final data1 = await _flutterSecureStorage?.read(key: typedStoreKey.key);
      if (data1 != null) {
        // coverage:ignore-start
        await _flutterSecureStorage?.delete(key: typedStoreKey.key);
        // coverage:ignore-end
      }
      final data2 = _sharedPreferences?.get(typedStoreKey.key);
      if (data2 != null) {
        await _sharedPreferences?.remove(typedStoreKey.key);
      }
      return;
    }

    /// реализация незащищенного хранилища или хранилища веба
    if (!typedStoreKey.secure) {
      switch (T) {
        case const (int):
          await _sharedPreferences?.setInt(
            typedStoreKey.key,
            value as int,
          );
        case const (String):
          await _sharedPreferences?.setString(
            typedStoreKey.key,
            value as String,
          );
        case const (double):
          await _sharedPreferences?.setDouble(
            typedStoreKey.key,
            value as double,
          );
        case const (bool):
          await _sharedPreferences?.setBool(
            typedStoreKey.key,
            value as bool,
          );
        case const (List):
          await _sharedPreferences?.setStringList(
            typedStoreKey.key,
            value as List<String>,
          );
      }
      return;
    }

    final String storableValue;

    if (T is List) {
      storableValue = jsonEncode(value);
    } else {
      storableValue = value.toString();
    }

    await _flutterSecureStorage?.write(
      key: typedStoreKey.key,
      value: storableValue,
    );
  }

  Future<void> clear() async {
    if (_sharedPreferences == null || _flutterSecureStorage == null) {
      // coverage:ignore-start
      throw Exception('KeyValueStore not initialized');
      // coverage:ignore-end
    }
    await _flutterSecureStorage?.deleteAll();
    await _sharedPreferences?.clear();
  }
}

class StoreKey<T> {
  const StoreKey(
    this.key, {
    this.secure = false,
  });

  final String key;
  final bool secure;

  // coverage:ignore-start
  Type get type => T;

  @override
  String toString() => 'StoreKey<$type>(key: $key, secure: $secure)';
// coverage:ignore-end
}
