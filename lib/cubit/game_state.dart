import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class GameState extends Equatable {
  final MarkMatrix boardRepresentation;
  final Mark turn;
  final GameStatus? gameStatus;
  final Duration remainingTime;

  GameState.initialize(Game game)
      : boardRepresentation = game.boardRepresentation,
        turn = game.turn,
        gameStatus = null,
        remainingTime = game.timerDuration;

  const GameState({
    this.boardRepresentation = const [],
    this.turn = Mark.x,
    this.remainingTime = Duration.zero,
    this.gameStatus,
  });

  GameState copyWith({
    MarkMatrix? boardRepresentation,
    Mark? turn,
    GameStatus? gameStatus,
    Duration? remainingTime,
  }) =>
      GameState(
        boardRepresentation: boardRepresentation ?? this.boardRepresentation,
        turn: turn ?? this.turn,
        remainingTime: remainingTime ?? this.remainingTime,
        gameStatus: gameStatus,
      );

  @override
  List<Object?> get props =>
      [boardRepresentation, turn, gameStatus, remainingTime];
}
