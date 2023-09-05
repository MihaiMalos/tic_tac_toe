import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_game/ui/screens/game_screen/cubit/game_cubit.dart';
import 'package:tic_tac_toe_game/ui/screens/game_screen/cubit/game_state.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('GameCubit', () {
    late GameCubit gameCubit;
    setUp(() {
      gameCubit = GameCubit();
      gameCubit.strategy = Strategy.twoPlayers;
    });

    test('initial state is correct', () {
      expect(gameCubit.state, const GameState());
    });

    blocTest<GameCubit, GameState>(
      'emits correct state after restarting the game',
      build: () => gameCubit,
      act: (cubit) => cubit.restart(),
      expect: () => [GameState.initialize(gameCubit.game)],
    );

    blocTest<GameCubit, GameState>(
      'emits correct state after placing a mark',
      build: () => gameCubit,
      act: (cubit) => cubit.placeMark(Position(0, 0)),
      expect: () => [
        GameState(
            boardRepresentation: gameCubit.game.boardRepresentation,
            turn: gameCubit.game.turn)
      ],
    );

    blocTest<GameCubit, GameState>(
      'emits correct state after stopping the game',
      build: () => gameCubit,
      act: (cubit) => cubit.stop(),
      expect: () => [GameState.initialize(gameCubit.game)],
    );

    // Add more tests as needed
  });
}
