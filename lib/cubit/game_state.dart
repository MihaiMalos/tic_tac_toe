import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class GameState extends Equatable {
  final MarkMatrix boardRepresentation;
  final Mark turn;
  final GameEvent gameOverState;

  const GameState(
      {this.boardRepresentation = const [],
      this.turn = Mark.x,
      this.gameOverState = GameEvent.playing});

  GameState copyWith(
          {MarkMatrix? boardRepresentation,
          Mark? turn,
          GameEvent? gameOverState}) =>
      GameState(
          boardRepresentation: boardRepresentation ?? this.boardRepresentation,
          turn: turn ?? this.turn,
          gameOverState: gameOverState ?? this.gameOverState);

  @override
  List<Object?> get props => [boardRepresentation, turn, gameOverState];
}
