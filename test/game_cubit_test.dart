import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_game/screens/game_screen/cubit/game_cubit.dart';
import 'package:tic_tac_toe_game/screens/game_screen/cubit/game_state.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([MockSpec<Game>()])
import 'game_cubit_test.mocks.dart';

void main() {
  group('GameCubit', () {
    blocTest<GameCubit, GameState>(
      'init state',
      build: () => GameCubit(),
      act: (cubit) {
        expect(
          cubit.state.boardRepresentation,
          const [
            [Mark.empty, Mark.empty, Mark.empty],
            [Mark.empty, Mark.empty, Mark.empty],
            [Mark.empty, Mark.empty, Mark.empty],
          ],
        );
        expect(cubit.state.turn, Mark.x);
        expect(cubit.state.remainingTime, Duration.zero);
      },
    );

    blocTest<GameCubit, GameState>(
      'set strategy',
      build: () => GameCubit(),
      act: (cubit) {
        MockGame mockGame = MockGame();
        cubit.game = mockGame;
        cubit.strategy = Strategy.medium;

        verify(mockGame.strategy = Strategy.medium).called(1);
      },
    );

    blocTest<GameCubit, GameState>(
      'placeMark command',
      build: () => GameCubit(),
      act: (cubit) {
        MockGame mockGame = MockGame();
        cubit.game = mockGame;
        cubit.placeMark(Position(0, 1));
        verify(mockGame.placeMark(Position(0, 1))).called(1);
      },
    );

    blocTest<GameCubit, GameState>(
      'startTimer command',
      build: () => GameCubit(),
      act: (cubit) {
        MockGame mockGame = MockGame();
        cubit.game = mockGame;
        cubit.startTimer();
        verify(mockGame.startTimer()).called(1);
      },
    );

    blocTest<GameCubit, GameState>(
      'restart command',
      build: () => GameCubit(),
      act: (cubit) {
        MockGame mockGame = MockGame();
        cubit.game = mockGame;
        cubit.restart();
        verify(mockGame.restart()).called(1);
      },
    );

    blocTest<GameCubit, GameState>(
      'stop command',
      build: () => GameCubit(),
      act: (cubit) {
        MockGame mockGame = MockGame();
        cubit.game = mockGame;
        cubit.stop();
        verify(mockGame.restart()).called(1);
        verify(mockGame.stopTimer()).called(1);
      },
    );

    blocTest<GameCubit, GameState>('onPlaceMark event',
        build: () => GameCubit(),
        act: (cubit) {
          MockGame mockGame = MockGame();
          when(mockGame.boardRepresentation).thenReturn([
            [Mark.x, Mark.empty, Mark.empty],
            [Mark.empty, Mark.empty, Mark.empty],
            [Mark.empty, Mark.empty, Mark.empty],
          ]);
          when(mockGame.turn).thenReturn(Mark.x);

          cubit.game = mockGame;
          cubit.onPlaceMark(Position(0, 0), false);
        },
        expect: () => [
              const GameState(
                boardRepresentation: [
                  [Mark.x, Mark.empty, Mark.empty],
                  [Mark.empty, Mark.empty, Mark.empty],
                  [Mark.empty, Mark.empty, Mark.empty],
                ],
                turn: Mark.x,
                gameStatus: null,
                remainingTime: Duration.zero,
              )
            ]);

    blocTest<GameCubit, GameState>('onTimerTick event',
        build: () => GameCubit(),
        act: (cubit) {
          MockGame mockGame = MockGame();

          cubit.game = mockGame;
          cubit.onTimerTick(const Duration(milliseconds: 3200));
        },
        expect: () => [
              const GameState(
                boardRepresentation: [
                  [Mark.empty, Mark.empty, Mark.empty],
                  [Mark.empty, Mark.empty, Mark.empty],
                  [Mark.empty, Mark.empty, Mark.empty],
                ],
                remainingTime: Duration(milliseconds: 3200),
              )
            ]);

    blocTest<GameCubit, GameState>('onGameOver event',
        build: () => GameCubit(),
        act: (cubit) {
          MockGame mockGame = MockGame();

          cubit.game = mockGame;
          cubit.onGameOver(GameStatus.oWon);
        },
        expect: () => [
              const GameState(boardRepresentation: [
                [Mark.empty, Mark.empty, Mark.empty],
                [Mark.empty, Mark.empty, Mark.empty],
                [Mark.empty, Mark.empty, Mark.empty],
              ], gameStatus: GameStatus.oWon)
            ]);
  });
}
