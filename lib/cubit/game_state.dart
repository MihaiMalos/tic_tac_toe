import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class GameState extends Equatable {
  final MarkMatrix boardRepresentation;
  final Mark turn;
  final GameEvent gameState;

  const GameState(
      {this.boardRepresentation = const [],
      this.turn = Mark.x,
      this.gameState = GameEvent.playing});

  GameState copyWith(
          {MarkMatrix? boardRepresentation,
          Mark? turn,
          GameEvent? gameState}) =>
      GameState(
          boardRepresentation: boardRepresentation ?? this.boardRepresentation,
          turn: turn ?? this.turn,
          gameState: gameState ?? this.gameState);

  @override
  List<Object?> get props => [boardRepresentation, turn, gameState];
}
