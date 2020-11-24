import 'dart:math';

import 'package:flutter/material.dart';

import '../models/board.dart';
import '../models/position.dart';
import 'board_tile.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  final void Function(Position) onTileTap;

  const BoardWidget({@required this.board, @required this.onTileTap});

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 10.0;
    final double boardDim =
        min((MediaQuery.of(context).size.width - 2 * horizontalPadding), 600);
    final double tileDim = (boardDim - 2 * horizontalPadding) / board.length;

    final List<Row> rows = <Row>[];

    for (int x = 0; x < board.length; x++) {
      final List<BoardTile> rowElements = <BoardTile>[];

      for (int y = 0; y < board.length; y++) {
        final Position p = Position(x, y);
        rowElements.add(
          BoardTile(
            board[x][y],
            onTap: board.emptySquare != p ? () => onTileTap(p) : null,
            dim: tileDim,
          ),
        );
      }

      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowElements,
      ));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: rows,
    );
  }
}
