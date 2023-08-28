import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class TicTacToeState {}

class GameContinueState extends TicTacToeState {
  MarkMatrix boardRepresentation;
  Mark turn;

  GameContinueState({required this.boardRepresentation, required this.turn});
}

class GameOverState extends TicTacToeState {
  //Player
  GameState gameOverState;

  GameOverState({required this.gameOverState});
}
