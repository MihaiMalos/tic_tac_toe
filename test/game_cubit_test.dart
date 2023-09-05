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
      'Cubit init state',
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
      'Cubit set strategy',
      build: () => GameCubit(),
      act: (cubit) {
        MockGame mockGame = MockGame();
        cubit.game = mockGame;
        cubit.strategy = Strategy.medium;

        verify(mockGame.strategy = Strategy.medium).called(1);
      },
    );

    blocTest<GameCubit, GameState>(
      'Cubit placeMark command',
      build: () => GameCubit(),
      act: (cubit) {
        MockGame mockGame = MockGame();
        cubit.game = mockGame;
        cubit.placeMark(Position(0, 1));
        verify(mockGame.placeMark(Position(0, 1))).called(1);
      },
    );

    blocTest<GameCubit, GameState>('Cubit onPlaceMark event',
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
              const GameState(boardRepresentation: [
                [Mark.x, Mark.empty, Mark.empty],
                [Mark.empty, Mark.empty, Mark.empty],
                [Mark.empty, Mark.empty, Mark.empty],
              ], turn: Mark.x, gameStatus: null, remainingTime: Duration.zero)
            ]);

    blocTest<GameCubit, GameState>('Cubit onGameOver event',
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
