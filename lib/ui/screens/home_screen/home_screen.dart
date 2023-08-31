import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe_game/cubit/game_cubit.dart';
import 'package:tic_tac_toe_game/cubit/game_state.dart';
import 'package:tic_tac_toe_game/main.dart';
import 'package:tic_tac_toe_game/ui/animations/confetti_animation.dart';
import 'package:tic_tac_toe_game/ui/screens/home_screen/widgets/board_widget.dart';
import 'package:tic_tac_toe_game/ui/screens/home_screen/widgets/turn_widget.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameCubit = getIt.get<GameCubit>();
    late String winnerLabel;
    return BlocConsumer<GameCubit, GameState>(
      bloc: gameCubit,
      listener: (context, state) => {
        if (state.gameState.isGameOver)
          {
            if (state.gameState == GameEvent.oWon)
              winnerLabel = "O won!"
            else if (state.gameState == GameEvent.xWon)
              winnerLabel = "X won"
            else
              winnerLabel = "Draw",
            showDialog<String>(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => WillPopScope(
                onWillPop: () => Future.value(false),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AlertDialog(
                      backgroundColor: const Color.fromARGB(255, 240, 192, 89),
                      title: Center(
                        child: Text(winnerLabel),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            gameCubit.restart();
                            Navigator.of(context).pop();
                          },
                          child: const Center(
                              child: Text('Restart',
                                  style: TextStyle(color: Colors.green))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          }
      },
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
