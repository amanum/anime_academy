part of 'comics_bloc.dart';

/// Базовый класс для всех событий блока комиксов
@immutable
sealed class ComicsEvent extends Equatable {
  const ComicsEvent();
  
  @override
  List<Object?> get props => [];
}

/// Событие загрузки списка комиксов
class ComicsEventLoad extends ComicsEvent {
  const ComicsEventLoad();
} 