import 'package:anime_academy/core/entity/universe.dart';
import 'package:anime_academy/domain/repository/universe_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'universe_event.dart';

part 'universe_state.dart';

class UniverseBloc extends Bloc<UniverseEvent, UniverseState> {
  UniverseBloc({
    required UniverseRepository repository,
  })  : _repository = repository,
        super(UniverseStateLoading()) {
    on<UniverseEvent>(
      (event, emit) async {
        print('Received event: $event');
        return switch (event) {
          UniverseEventLoad() => _onLoad(event, emit),
          UniverseEventSelect() => _onSelect(event, emit),
        };
      },
    );
  }

  final UniverseRepository _repository;

  Future<void> _onLoad(
    UniverseEventLoad event,
    Emitter<UniverseState> emit,
  ) async {
    print('Loading universes...'); // Отладочный вывод
    try {
      final universes = await _repository.getUniverses();
      print('Loaded ${universes.length} universes'); // Отладочный вывод
      emit(UniverseStateLoaded(universes: universes));
    } catch (e) {
      print('Error loading universes: $e');
    }
  }

  Future<void> _onSelect(
    UniverseEventSelect event,
    Emitter<UniverseState> emit,
  ) async {}
}
