import 'dart:math';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/admob_factory.dart';
import '../config/flags.dart';
import '../logic/game_bloc.dart';
import '../models/game_status.dart';
import '../widgets/game_label.dart';
import '../widgets/game_raised_button.dart';

class EndScreen extends StatelessWidget {
  final int numberOfMovesMade;
  final Duration timeTaken;
  final GameStatus gameStatus;

  EndScreen({
    @required this.gameStatus,
    @required this.timeTaken,
    @required this.numberOfMovesMade,
  });

  factory EndScreen.fromGameStateAndStatus(
    GameState state,
    GameStatus status,
  ) =>
      EndScreen(
        gameStatus: status,
        timeTaken: state.gameDuration,
        numberOfMovesMade: state.movesMade,
      );

  void _addMoves() async {
    while (!(await RewardedVideoAd.instance.show())) {}
  }

  @override
  Widget build(BuildContext context) {
    if (Flags.enableRewardedAds) {
      RewardedVideoAd.instance.listener =
          (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
        if (event == RewardedVideoAdEvent.rewarded) {
          context.bloc<GameBloc>().addTime();
        }
      };

      RewardedVideoAd.instance.load(
        adUnitId: AdMobFactory.getRewardedAdUnitId(),
        targetingInfo: AdMobFactory.getTargetingInfo(),
      );
    }

    InterstitialAd newGameAd;
    if (Flags.enableInterstitialAds) {
      newGameAd = AdMobFactory.getInterstitialAd(
          onClosed: context.bloc<GameBloc>().newGame);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Image.asset(
                gameStatus == GameStatus.win
                    ? 'assets/images/party_popper.png'
                    : 'assets/images/cry_face.png',
                width: 140.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: max(50.0, MediaQuery.of(context).size.width / 10),
                ),
                child: Text(
                  gameStatus == GameStatus.win
                      ? 'Congratulations, you did it!'
                      : 'Too bad, try again?' +
                          (Flags.enableRewardedAds
                              ? ' Or watch an awesome video for extra time! 🤔'
                              : ''),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
          Hero(
            tag: 'clocks',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MovesPlayedLabel(numberOfMovesMade, isFlex: false),
                TimePassedLabel(timeTaken, isFlex: false),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              GameRaisedButtonWithIcon(
                onPressed: () {
                  if (Flags.enableInterstitialAds) {
                    newGameAd.show();
                  } else {
                    context.bloc<GameBloc>().newGame();
                  }
                },
                label: 'New Game',
                icon: CupertinoIcons.add,
              ),
              if (gameStatus != GameStatus.win) ...[
                GameRaisedButtonWithIcon(
                  onPressed: () => context.bloc<GameBloc>().restart(),
                  label: 'Try Again',
                  icon: CupertinoIcons.refresh,
                ),
                if (Flags.enableRewardedAds) ...[
                  GameRaisedButtonWithIcon(
                    onPressed: _addMoves,
                    label: 'Continue Playing',
                    icon: CupertinoIcons.film,
                  ),
                ],
              ]
            ],
          ),
        ],
      ),
    );
  }
}
