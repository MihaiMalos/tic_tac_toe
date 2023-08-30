import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe_game/cubit/game_cubit.dart';
import 'package:tic_tac_toe_game/cubit/game_state.dart';
import 'package:tic_tac_toe_game/main.dart';
import 'package:tic_tac_toe_game/ui/screens/home_screen/widgets/board_widget.dart';
import 'package:tic_tac_toe_game/ui/screens/home_screen/widgets/turn_widget.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameCubit = getIt.get<GameCubit>();
    return BlocBuilder<GameCubit, GameState>(
      bloc: gameCubit,
      builder: (context, state) {
        return Scaffold(
            backgroundColor: const Color.fromARGB(255, 31, 30, 31),
            body: Center(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  TurnWidget(playerTurn: gameCubit.turn),
                  const SizedBox(height: 150),
                  Expanded(
                    child: BoardWidget(
                      state: state,
                      onPositionTap: (y, x) {
                        try {
                          gameCubit.placeMark(Position(y, x));
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
