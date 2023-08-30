import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/cubit/game_cubit.dart';
import 'package:tic_tac_toe_game/main.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromARGB(255, 31, 30, 31),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                'Choose difficulty',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 5,
                ),
              ),
              SizedBox(height: 100),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DifficultyButton(
                    difficultyName: 'Easy',
                    strategy: Strategy.easy,
                  ),
                  DifficultyButton(
                    difficultyName: 'Medium',
                    strategy: Strategy.medium,
                  ),
                  DifficultyButton(
                    difficultyName: 'Hard',
                    strategy: Strategy.hard,
                  ),
                  DifficultyButton(
                    difficultyName: 'Two Players',
                    strategy: Strategy.twoPlayers,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class DifficultyButton extends StatelessWidget {
  final String difficultyName;
  final Strategy strategy;

  const DifficultyButton({
    super.key,
    required this.difficultyName,
    required this.strategy,
  });

  @override
  Widget build(BuildContext context) {
    final gameCubit = getIt.get<GameCubit>();
    return SizedBox(
      height: 50,
      child: MaterialButton(
        hoverColor: const Color.fromARGB(255, 167, 60, 153),
        onPressed: () {
          gameCubit.initializeGame(strategy);
          Navigator.of(context).pushNamed('/home');
        },
        child: Text(
          difficultyName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
