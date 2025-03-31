part of 'comics_bloc.dart';

/// Базовый класс для всех состояний блока комиксов
@immutable
sealed class ComicsState extends Equatable {
  const ComicsState();
  
  @override
  List<Object?> get props => [];
}

/// Состояние загрузки комиксов
class ComicsStateLoading extends ComicsState {}

/// Состояние, когда комиксы успешно загружены
class ComicsStateLoaded extends ComicsState {
  final List<Comics> comics;
  
  const ComicsStateLoaded({
    required this.comics,
  });
  
  @override
  List<Object?> get props => [comics];
}

/// Состояние ошибки при загрузке комиксов
class ComicsStateError extends ComicsState {
  final String message;
  
  const ComicsStateError({
    required this.message,
  });
  
  @override
  List<Object?> get props => [message];
} 