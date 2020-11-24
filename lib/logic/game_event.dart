part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class MoveMadeEvent extends GameEvent {
  final Position p;

  MoveMadeEvent(this.p);
}

class UndoMoveEvent extends GameEvent {}

class RestartEvent extends GameEvent {}

class NewGameEvent extends GameEvent {}

class VideoWatchedEvent extends GameEvent {}

class ClockTickedEvent extends GameEvent {}
