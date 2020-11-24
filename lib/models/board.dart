import 'position.dart';

class Board {
  List<List<int>> board;
  Position emptySquare;

  Board() {
    _generateInitialBoard();
  }

  int get length => board.length;
  List<int> operator [](int idx) => board[idx];

  bool move(Position p) {}

  void _generateInitialBoard() {
    board = <List<int>>[
      <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
      <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
      <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
      <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
      <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
      <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
      <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
      <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
      <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
    ];
  }

  @override
  String toString() {
    String str = '';
    board.forEach((List<int> row) {
      row.forEach((int x) {
        str += '$x ';
      });
      str += '\n';
    });
    return str;
  }
}
