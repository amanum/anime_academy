part of 'test_bloc.dart';

/// Базовый класс для всех состояний блока тестов
@immutable
sealed class TestState extends Equatable {
  const TestState();
  
  @override
  List<Object?> get props => [];
}

/// Состояние загрузки тестов
class TestStateLoading extends TestState {}

/// Состояние, когда тесты успешно загружены
class TestStateLoaded extends TestState {
  final List<AniTest> tests;
  
  const TestStateLoaded({
    required this.tests,
  });
  
  @override
  List<Object?> get props => [tests];
}

/// Состояние ошибки при загрузке тестов
class TestStateError extends TestState {
  final String message;
  
  const TestStateError({
    required this.message,
  });
  
  @override
  List<Object?> get props => [message];
} 