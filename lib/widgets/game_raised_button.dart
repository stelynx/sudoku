import 'dart:math';

import 'package:flutter/material.dart';

class GameRaisedButtonWithIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const GameRaisedButtonWithIcon({
    @required this.onPressed,
    @required this.icon,
    @required this.label,
  });

  double _getElevation(Set<MaterialState> states) {
    return states.contains(MaterialState.pressed) ? 0.0 : 5.0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: max(MediaQuery.of(context).size.width / 2, 180),
      child: Container(
        height: max(min(60.0, MediaQuery.of(context).size.height / 12), 40.0),
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(
            label,
            style: TextStyle(
              fontSize: min(16, MediaQuery.of(context).size.height / 60),
            ),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
            ),
            elevation: MaterialStateProperty.resolveWith<double>(_getElevation),
            animationDuration: Duration(milliseconds: 500),
          ),
        ),
      ),
    );
  }
}
