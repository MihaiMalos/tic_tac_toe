import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class GameState extends Equatable {
  final MarkMatrix boardRepresentation;
  final Mark turn;
  final GameEvent? gameEvent;

  const GameState({
    this.boardRepresentation = const [],
    this.turn = Mark.x,
    this.gameEvent,
  });

  GameState copyWith(
          {MarkMatrix? boardRepresentation,
          Mark? turn,
          GameEvent? gameEvent}) =>
      GameState(
          boardRepresentation: boardRepresentation ?? this.boardRepresentation,
          turn: turn ?? this.turn,
          gameEvent: gameEvent);

  @override
  List<Object?> get props => [boardRepresentation, turn, gameEvent];
}
