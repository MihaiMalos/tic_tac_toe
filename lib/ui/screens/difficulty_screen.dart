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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DifficultyButton(
                    difficultyName: 'Easy',
                    strategy: Strategy.easy,
                  ),
                  SizedBox(height: 10),
                  DifficultyButton(
                    difficultyName: 'Medium',
                    strategy: Strategy.medium,
                  ),
                  SizedBox(height: 10),
                  DifficultyButton(
                    difficultyName: 'Hard',
                    strategy: Strategy.hard,
                  ),
                  SizedBox(height: 10),
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
    return TextButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 37, 36, 36))))),
      child: Center(
        child: Text(
          difficultyName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      onPressed: () {
        getIt.get<GameCubit>().initializeGame(strategy);
        Navigator.of(context).pushNamed('/home');
      },
    );
  }
}
