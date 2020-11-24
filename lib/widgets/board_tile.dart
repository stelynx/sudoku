import 'package:flutter/material.dart';

class BoardTile extends StatelessWidget {
  final int x;
  final VoidCallback onTap;
  final double dim;

  const BoardTile(
    this.x, {
    @required this.onTap,
    @required this.dim,
  });

  @override
  Widget build(BuildContext context) {
    final double fontSize = 0.5 * dim;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: dim,
        width: dim,
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
        ),
        child: Center(
          child: Text(
            x != null ? '$x' : '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
