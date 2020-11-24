import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../config/config.dart';
import '../models/board.dart';
import '../models/game_status.dart';
import '../models/position.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  Timer timer;

  GameBloc() : super(GameState.initial()) {
    timer = Timer.periodic(Duration(seconds: 1), _tickClock);
  }

  void move(Position p) => this.add(MoveMadeEvent(p));
  void undo() => this.add(UndoMoveEvent());
  void restart() => this.add(RestartEvent());
  void newGame() => this.add(NewGameEvent());
  void addTime() => this.add(VideoWatchedEvent());
  void _tickClock(Timer timer) =>
      timer.isActive ? this.add(ClockTickedEvent()) : null;

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is MoveMadeEvent) {
      final Position moveTarget = state.board.emptySquare;

      final bool isSuccessful = state.board.move(event.p);
      if (!isSuccessful) return;

      state.moves.add(moveTarget);

      yield state.copyWith();

      bool isComplete = true;
      for (int x = 0; x < state.board.length; x++) {
        for (int y = 0; y < state.board.length; y++) {
          if (state.board[x][y] != x * state.board.length + y + 1 &&
              (x != state.board.length - 1 || y != state.board.length - 1)) {
            isComplete = false;
            break;
          }
        }
        if (!isComplete) break;
      }

      if (isComplete) {
        timer.cancel();
        yield state.copyWith(status: GameStatus.win);
      }
    } else if (event is NewGameEvent) {
      timer = Timer.periodic(Duration(seconds: 1), _tickClock);
      yield GameState.initial();
    } else if (event is UndoMoveEvent) {
      state.board.move(state.moves.removeLast());
      yield state.copyWith();
    } else if (event is RestartEvent) {
      while (state.moves.isNotEmpty) {
        state.board.move(state.moves.removeLast());
      }

      final bool restartFromFinishedGame = !timer.isActive;
      if (restartFromFinishedGame)
        timer = Timer.periodic(Duration(seconds: 1), _tickClock);
      yield state.copyWith(
        status: GameStatus.playing,
        gameDuration: restartFromFinishedGame ? Duration(seconds: 0) : null,
      );
    } else if (event is VideoWatchedEvent) {
      timer = Timer.periodic(Duration(seconds: 1), _tickClock);
      yield state.copyWith(
        status: GameStatus.playing,
        maxSeconds: state.maxSeconds + Config.videoExtendsTime,
      );
    } else if (event is ClockTickedEvent) {
      yield state.copyWith(
          gameDuration: state.gameDuration + Duration(seconds: 1));

      if (state.gameDuration.inSeconds == state.maxSeconds) {
        timer.cancel();
        yield state.copyWith(status: GameStatus.outOfTime);
        return;
      }
    }
  }
}
