import 'dart:async';

import 'package:anime_academy/data/auth_status_result.dart';
import 'package:anime_academy/data/token_data.dart';
import 'package:anime_academy/data/auth_store_result.dart';
import 'package:anime_academy/domain/repository/auth_status_repository.dart';
import 'package:anime_academy/domain/repository/auth_store_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_status_event.dart';

part 'auth_status_state.dart';

class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  AuthStatusBloc({
    required AuthStatusRepository repository,
    required AuthStoreRepository authStoreRepository,
    required this.isAuthorized,
  })  : _repository = repository,
        _authStoreRepository = authStoreRepository,
        super(const AuthStatusState$Initial()) {
    on<AuthStatusEvent>(
      (event, emit) {
        return switch (event) {
          AuthStatusEvent$Init() => _init(event, emit),
          AuthStatusEvent$Set() => _set(event, emit),
          AuthStatusEvent$SetToken() => _setToken(event, emit),
          AuthStatusEvent$RefreshToken() => _refreshToken(event, emit),
          AuthStatusEvent$Logout() => _logout(event, emit),
        };
      },
    );
    _refreshTokenSubscription = authStoreRepository.tokenStream.listen(
      _refreshTokenListener,
    );

    add(const AuthStatusEvent$Init());
  }

  /// Признак авторизации.
  final bool isAuthorized;

  final AuthStatusRepository _repository;
  final AuthStoreRepository _authStoreRepository;

  late final StreamSubscription<TokenData?> _refreshTokenSubscription;

  void _refreshTokenListener(TokenData? token) {
    add(const AuthStatusEvent$RefreshToken());
  }

  @override
  Future<void> close() async {
    await _refreshTokenSubscription.cancel();
    await super.close();
  }

  void _init(
    AuthStatusEvent$Init event,
    Emitter<AuthStatusState> emit,
  ) {
    if (isAuthorized) {
      emit(AuthStatusState$Authorized());
    } else {
      emit(const AuthStatusState$Unauthorized());
    }
  }

  void _set(
    AuthStatusEvent$Set event,
    Emitter<AuthStatusState> emit,
  ) {
    if (event.authorized) {
      emit(
        AuthStatusState$Authorized(),
      );
    } else {
      emit(const AuthStatusState$Unauthorized());
    }
  }

  Future<void> _refreshToken(
    AuthStatusEvent$RefreshToken event,
    Emitter<AuthStatusState> emit,
  ) async {
    final result = await _authStoreRepository.getToken();
    switch (result) {
      case AuthStoreResultSuccess<TokenData>():
        add(AuthStatusEvent$Set(authorized: result.data != null));
      case AuthStoreResultFailure<TokenData>():
        emit(const AuthStatusState$LocalStorageError());
    }
  }

  Future<void> _setToken(
    AuthStatusEvent$SetToken event,
    Emitter<AuthStatusState> emit,
  ) async {
    final token = event.token;
    final result = await _authStoreRepository.setToken(token);

    switch (result) {
      case AuthStoreResultSuccess<void>():
        add(AuthStatusEvent$Set(authorized: token != null));
      case AuthStoreResultFailure<void>():
        emit(const AuthStatusState$LocalStorageError());
    }
  }

  Future<void> _logout(
    AuthStatusEvent$Logout event,
    Emitter<AuthStatusState> emit,
  ) async {
    emit(const AuthStatusState$Processing());
    final tokenResult = await _authStoreRepository.getToken();
    switch (tokenResult) {
      case AuthStoreResultSuccess<TokenData>():
        final refreshToken = tokenResult.data?.refreshToken;
        if (refreshToken == null) {
          emit(const AuthStatusState$LocalStorageError());
          return;
        }
        final logoutResult = await _repository.logout(
          refreshToken: refreshToken,
        );
        switch (logoutResult) {
          case AuthStatusResult$Success<void>():
            await _authStoreRepository.cleanStore();
            emit(const AuthStatusState$Unauthorized());
          case AuthStatusResult$LogoutFailure<void>():
            addError(logoutResult.error, logoutResult.stackTrace);
            emit(const AuthStatusState$ServerConnectionError());
            await _authStoreRepository.cleanStore();
            emit(const AuthStatusState$Unauthorized());
        }
      case AuthStoreResultFailure<TokenData>():
        addError(tokenResult.error, tokenResult.stackTrace);
        emit(const AuthStatusState$ServerConnectionError());
    }
  }
}
