import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/admob_factory.dart';
import '../config/flags.dart';
import '../logic/game_bloc.dart';
import '../models/board.dart';
import '../widgets/board_widget.dart';
import '../widgets/game_controller_button.dart';
import '../widgets/game_label.dart';

class GameScreen extends StatelessWidget {
  final Board board;
  final Duration timePlaying;
  final bool displayBackAndResetButtons;

  const GameScreen({
    @required this.board,
    @required this.timePlaying,
    @required this.displayBackAndResetButtons,
  });

  @override
  Widget build(BuildContext context) {
    if (Flags.enableBannerAds) {
      AdMobFactory.getBannerAd().show();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Hero(
          tag: 'clocks',
          child: TimePassedLabel(timePlaying),
        ),
        BoardWidget(
          board: board,
          onTileTap: context.bloc<GameBloc>().move,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GameControllerButton(
              onTap: context.bloc<GameBloc>().undo,
              icon: CupertinoIcons.back,
              enabled: displayBackAndResetButtons,
            ),
            GameControllerButton(
              onTap: context.bloc<GameBloc>().restart,
              icon: CupertinoIcons.restart,
              enabled: displayBackAndResetButtons,
            ),
            GameControllerButton(
              onTap: context.bloc<GameBloc>().newGame,
              icon: CupertinoIcons.add,
            ),
          ],
        ),
      ],
    );
  }
}
