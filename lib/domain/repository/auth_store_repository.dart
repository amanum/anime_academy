import 'dart:async';
import 'dart:convert';

import 'package:anime_academy/app/const/store_keys.dart';
import 'package:anime_academy/app/models/key_value_store.dart';
import 'package:anime_academy/data/token_data.dart';
import 'package:anime_academy/data/auth_store_result.dart';

class AuthStoreRepository {
  AuthStoreRepository({
    required KeyValueStore store,
  }) : _store = store;

  final KeyValueStore _store;

  final StreamController<TokenData?> _tokenController =
      StreamController.broadcast();

  Stream<TokenData?> get tokenStream => _tokenController.stream;

  Future<AuthStoreResult<TokenData>> getToken() async {
    try {
      final tokenJson = await _store.read<String>(StoreKeys.token);
      if (tokenJson == null) {
        return const AuthStoreResultSuccess<TokenData>();
      }
      final token = TokenData.fromJson(
        json.decode(tokenJson) as Map<String, Object?>,
      );
      return AuthStoreResultSuccess<TokenData>(data: token);
    } catch (e, s) {
      return AuthStoreResultFailure(e, s);
    }
  }

  Future<AuthStoreResult<void>> setToken(TokenData? token) async {
    try {
      final savedToken = token == null
          ? null
          : json.encode(
              token.toJson(),
            );
      await _store.write<String>(
        StoreKeys.token,
        savedToken,
      );
      _tokenController.add(token);
      return const AuthStoreResultSuccess();
    } catch (e, s) {
      return AuthStoreResultFailure(e, s);
    }
  }

  Future<AuthStoreResult<void>> cleanStore() async {
    try {
      await _store.clear();
      return const AuthStoreResultSuccess();
    } catch (e, s) {
      return AuthStoreResultFailure(e, s);
    }
  }
}
