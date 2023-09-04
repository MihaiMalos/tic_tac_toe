import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe_game/cubit/game_cubit.dart';
import 'package:tic_tac_toe_game/cubit/game_state.dart';
import 'package:tic_tac_toe_game/main.dart';
import 'package:tic_tac_toe_game/ui/screens/home_screen/widgets/board_widget.dart';
import 'package:tic_tac_toe_game/ui/screens/home_screen/widgets/dialog_widget.dart';
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
        if (state.gameEvent != null)
          {
            if (state.gameEvent!.isOWinner)
              winnerLabel = "O won!"
            else if (state.gameEvent!.isXWinner)
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
                    GameWinDialog(
                      onPressed: gameCubit.restart,
                      winnerLabel: winnerLabel,
                    )
                  ],
                ),
              ),
            )
          }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 7),
                  TurnWidget(playerTurn: gameCubit.turn),
                  SizedBox(height: MediaQuery.of(context).size.height / 9),
                  Expanded(
                    child: BoardWidget(
                      state: state,
                      onPositionTap: (y, x) async {
                        try {
                          await gameCubit.placeMark(Position(y, x));
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ButtonStyle(
                      fixedSize: const MaterialStatePropertyAll(Size(150, 0)),
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.background),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      )),
                    ),
                    child: Text(
                      'RETURN HOME',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8), fontSize: 15),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 6),
                ],
              ),
            ));
      },
    );
  }
}
