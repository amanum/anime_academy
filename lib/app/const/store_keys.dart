import 'package:anime_academy/app/models/key_value_store.dart';

/// Статическое хранилище ключей [StoreKey] используемых в приложении
class StoreKeys {
  StoreKeys._();

  // TODO(umurzakov): remove unused
  /* #region Dev */
  // static final prefsVersionKey = StoreKey<int>('prefs_version_key');
  //
  // static final debugEnv = StoreKey<String>('debugEnv');
  // /* #endregion */
  //
  // /* #region Locker */
  // static final bio = StoreKey<bool>('bio-authentication-status', secure: true);
  //
  // static final pin = StoreKey<String>('pin', secure: true);
  /* #endregion */

  /* #region Authentication */
  static const token = StoreKey<String>('token', secure: true); //TODO: set to true after preparing Apple Team Account

  // static final lastUsername = StoreKey<String>('lastUsername', secure: true);
  //
  // static final lastLogin = StoreKey<String>('lastLogin', secure: true);
  /* #endregion */

  // static final requestedRoute = StoreKey<String>('requestedRoute');
  // static final settings = StoreKey<String>('settings');
  //
  // static final domain = StoreKey<String>('domain');
  //
  // static final sphereType = StoreKey<String>('sphere_type');
  //
  // static final deviceId = StoreKey<String>('deviceId', secure: true);

  /// Состояние приложения
  static const appState = StoreKey<String>('app_state', secure: true);
}