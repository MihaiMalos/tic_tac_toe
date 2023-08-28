import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe_game/cubit/game_cubit.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class DifficultyScreen extends StatefulWidget {
  const DifficultyScreen({super.key});

  @override
  State<DifficultyScreen> createState() => _DifficultyScreenState();
}

class _DifficultyScreenState extends State<DifficultyScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromARGB(255, 37, 36, 36),
        body: Center(
          child: Column(
            children: [
              Text(
                'Choose difficulty',
                style: TextStyle(color: Colors.white),
              ),
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
    return BlocProvider(
      create: (context) => GameCubit(),
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(18.0),
          color: Colors.green,
          child: Text(
            difficultyName,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        onTap: () {
          context.read<GameCubit>().initializeGame(strategy);
          Navigator.of(context).pushNamed('/home');
        },
      ),
    );
  }
}
