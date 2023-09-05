import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/animations/confetti_animation.dart';

class GameWinDialog extends StatelessWidget {
  final Function onPressed;
  final String winnerLabel;
  const GameWinDialog(
      {super.key, required this.onPressed, required this.winnerLabel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Center(
        child: CustomConfettiWidget(
            child:
                Text(winnerLabel, style: const TextStyle(color: Colors.black))),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      actions: <Widget>[
        Center(
          child: TextButton(
            style: ButtonStyle(
              fixedSize: const MaterialStatePropertyAll(Size(100, 0)),
              backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.background),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100))),
            ),
            onPressed: () {
              onPressed();
              Navigator.of(context).pop();
            },
            child: const Center(
                child: Text('Restart', style: TextStyle(color: Colors.white))),
          ),
        ),
      ],
    );
  }
}
