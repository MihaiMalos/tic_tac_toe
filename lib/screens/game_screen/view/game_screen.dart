import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe_game/main.dart';
import 'package:tic_tac_toe_game/ui/screens/game_screen/cubit/game_cubit.dart';
import 'package:tic_tac_toe_game/ui/screens/game_screen/cubit/game_state.dart';
import 'package:tic_tac_toe_game/ui/screens/game_screen/view/widgets/board_widget.dart';
import 'package:tic_tac_toe_game/ui/screens/game_screen/view/widgets/dialog_widget.dart';
import 'package:tic_tac_toe_game/ui/screens/game_screen/view/widgets/turn_widget.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class GameScreen extends StatelessWidget {
  final Strategy gameStrategy;
  final gameCubit = getIt.get<GameCubit>();
  GameScreen({super.key, required this.gameStrategy}) {
    gameCubit.strategy = gameStrategy;
    gameCubit.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    late String winnerLabel;
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocConsumer<GameCubit, GameState>(
        bloc: gameCubit,
        listener: (context, state) => {
          if (state.gameStatus != null)
            {
              if (state.gameStatus!.isOWinner)
                winnerLabel = "O won!"
              else if (state.gameStatus!.isXWinner)
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                    TurnWidget(playerTurn: gameCubit.turn),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: LinearProgressIndicator(
                          value: state.remainingTime.inMilliseconds / 5000,
                          borderRadius: BorderRadius.circular(10),
                          backgroundColor: Colors.white),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
                      onPressed: () {
                        gameCubit.stop();
                        Navigator.of(context).pop();
                      },
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
