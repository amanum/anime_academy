import 'package:anime_academy/core/entity/comics.dart';
import 'package:anime_academy/domain/repository/comics_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'comics_event.dart';
part 'comics_state.dart';

/// Блок для управления состоянием комиксов
class ComicsBloc extends Bloc<ComicsEvent, ComicsState> {
  final ComicsRepository _repository;

  ComicsBloc({
    required ComicsRepository repository,
  })  : _repository = repository,
        super(ComicsStateLoading()) {
    on<ComicsEvent>((event, emit) async {
      return switch (event) {
        ComicsEventLoad() => _onLoad(event, emit),
      };
    });
  }

  /// Обработчик события загрузки комиксов
  Future<void> _onLoad(
    ComicsEventLoad event,
    Emitter<ComicsState> emit,
  ) async {
    emit(ComicsStateLoading());
    try {
      print('Загрузка комиксов...');
      final comics = await _repository.getComics();
      print('Загружено ${comics.length} комиксов');
      emit(ComicsStateLoaded(comics: comics));
    } catch (e) {
      print('Ошибка при загрузке комиксов: $e');
      emit(ComicsStateError(message: e.toString()));
    }
  }
} 