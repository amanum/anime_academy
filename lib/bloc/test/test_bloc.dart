import 'package:anime_academy/core/entity/ani_test.dart';
import 'package:anime_academy/domain/repository/test_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'test_event.dart';
part 'test_state.dart';

/// Блок для управления состоянием тестов
class TestBloc extends Bloc<TestEvent, TestState> {
  final TestRepository _repository;

  TestBloc({
    required TestRepository repository,
  })  : _repository = repository,
        super(TestStateLoading()) {
    on<TestEvent>((event, emit) async {
      return switch (event) {
        TestEventLoad() => _onLoad(event, emit),
      };
    });
  }

  /// Обработчик события загрузки тестов
  Future<void> _onLoad(
    TestEventLoad event,
    Emitter<TestState> emit,
  ) async {
    emit(TestStateLoading());
    try {
      print('Загрузка тестов...');
      final tests = await _repository.getTests();
      print('Загружено ${tests.length} тестов');
      emit(TestStateLoaded(tests: tests));
    } catch (e) {
      print('Ошибка при загрузке тестов: $e');
      emit(TestStateError(message: e.toString()));
    }
  }
} 