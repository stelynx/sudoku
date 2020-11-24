import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/game_bloc.dart';
import '../models/game_status.dart';
import 'end_screen.dart';
import 'game_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (BuildContext context, GameState state) {
        if (state.status == GameStatus.playing) {
          return GameScreen(
            board: state.board,
            timePlaying: state.gameDuration,
            displayBackAndResetButtons: state.movesMade > 0,
          );
        }

        return EndScreen(
          gameStatus: state.status,
          timeTaken: state.gameDuration,
          numberOfMovesMade: state.movesMade,
        );
      },
    );
  }
}
