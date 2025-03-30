import 'package:anime_academy/core/entity/user.dart';
import 'package:anime_academy/data/auth/auth_models.dart';
import 'package:anime_academy/domain/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      return switch (event) {
        AuthCheckRequested() => _onAuthCheckRequested(event, emit),
        AuthLoginRequested() => _onAuthLoginRequested(event, emit),
        AuthRegisterRequested() => _onAuthRegisterRequested(event, emit),
        AuthLogoutRequested() => _onAuthLogoutRequested(event, emit),
      };
    });
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final isAuthenticated = await _authRepository.isAuthenticated();
      if (isAuthenticated) {
        emit(const AuthSuccess());
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.login(
        identifier: event.identifier,
        password: event.password,
      );
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailure(message: 'Ошибка авторизации: ${e.toString()}'));
    }
  }

  Future<void> _onAuthRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.register(
        username: event.username,
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailure(message: 'Ошибка регистрации: ${e.toString()}'));
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.logout();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(message: 'Ошибка выхода: ${e.toString()}'));
    }
  }
} 