import 'package:flutter/material.dart';

class _GameLabel extends StatelessWidget {
  final String title;
  final String value;
  final bool isFlex;

  const _GameLabel({
    @required this.title,
    @required this.value,
    @required this.isFlex,
  });

  @override
  Widget build(BuildContext context) {
    if (isFlex)
      return Expanded(
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 10),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.w100),
            ),
          ],
        ),
      );

    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 10),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 60, fontWeight: FontWeight.w100),
        ),
      ],
    );
  }
}

class MovesPlayedLabel extends _GameLabel {
  const MovesPlayedLabel(int movesPlayed, {bool isFlex = true})
      : super(
          title: 'Moves',
          value: '$movesPlayed',
          isFlex: isFlex,
        );
}

class TimePassedLabel extends StatelessWidget {
  final Duration duration;
  final bool isFlex;

  const TimePassedLabel(this.duration, {this.isFlex = true});

  @override
  Widget build(BuildContext context) {
    String seconds = '0${duration.inSeconds % 60}';
    seconds = seconds.substring(seconds.length - 2);

    return _GameLabel(
      title: 'Time',
      value: '${duration.inMinutes}:$seconds',
      isFlex: isFlex,
    );
  }
}
