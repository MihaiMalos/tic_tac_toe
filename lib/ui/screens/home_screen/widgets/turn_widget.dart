import 'package:flutter/material.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class TurnWidget extends StatelessWidget {
  final Mark playerTurn;
  const TurnWidget({super.key, required this.playerTurn});
  @override
  Widget build(BuildContext context) {
    return Text(
      "${playerTurn.name.toUpperCase()}'s turn",
      style: const TextStyle(color: Colors.white, fontSize: 40),
    );
  }
}
