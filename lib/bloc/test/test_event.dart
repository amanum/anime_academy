part of 'test_bloc.dart';

/// Базовый класс для всех событий блока тестов
@immutable
sealed class TestEvent extends Equatable {
  const TestEvent();
  
  @override
  List<Object?> get props => [];
}

/// Событие загрузки списка тестов
class TestEventLoad extends TestEvent {
  const TestEventLoad();
} 