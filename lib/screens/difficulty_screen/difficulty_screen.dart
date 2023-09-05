import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_game/animations/bouncing_animation.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              BouncingWidget(
                child: SizedBox(
                  width: 300,
                  child: Image.asset("assets/images/logo.png"),
                ),
              ),
              const SizedBox(height: 50),
              Text(
                'CHOOSE\nDIFFICULTY',
                textAlign: TextAlign.center,
                style: GoogleFonts.pressStart2p(
                    color: Colors.white,
                    fontSize: 25,
                    letterSpacing: 5,
                    shadows: [
                      const Shadow(
                        color: Color.fromARGB(162, 255, 255, 255),
                        blurRadius: 40,
                      )
                    ]),
              ),
              const SizedBox(height: 50),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DifficultyButton(
                    difficultyName: 'EASY',
                    strategy: Strategy.easy,
                  ),
                  DifficultyButton(
                    difficultyName: 'MEDIUM',
                    strategy: Strategy.medium,
                  ),
                  DifficultyButton(
                    difficultyName: 'HARD',
                    strategy: Strategy.hard,
                  ),
                  DifficultyButton(
                    difficultyName: '2PLAYERS',
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
    return SizedBox(
      height: 50,
      child: MaterialButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/home', arguments: strategy);
        },
        child: Text(
          difficultyName,
          textAlign: TextAlign.center,
          style: GoogleFonts.pressStart2p(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
