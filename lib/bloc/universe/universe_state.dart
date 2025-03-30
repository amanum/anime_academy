part of 'universe_bloc.dart';

@immutable
sealed class UniverseState {
  const UniverseState();
}

final class UniverseStateLoading extends UniverseState {}

final class UniverseStateLoaded extends UniverseState {
  final List<Universe> universes;

  const UniverseStateLoaded({required this.universes});
}
