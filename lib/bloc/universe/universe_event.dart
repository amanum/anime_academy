part of 'universe_bloc.dart';

@immutable
sealed class UniverseEvent {
  const UniverseEvent();
}

class UniverseEventLoad extends UniverseEvent {
  const UniverseEventLoad();
}

class UniverseEventSelect extends UniverseEvent {
  final int universeId;
  const UniverseEventSelect({required this.universeId});
}
