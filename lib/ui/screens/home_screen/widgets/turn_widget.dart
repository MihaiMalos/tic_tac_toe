import 'package:flutter/material.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class TurnWidget extends StatelessWidget {
  final Mark playerTurn;
  const TurnWidget({super.key, required this.playerTurn});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PlayerTurnWidget(player: Mark.x, turn: playerTurn),
          const SizedBox(width: 30),
          PlayerTurnWidget(player: Mark.o, turn: playerTurn),
        ],
      ),
    );
  }
}

class PlayerTurnWidget extends StatelessWidget {
  final Mark player, turn;
  const PlayerTurnWidget({super.key, required this.player, required this.turn});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
        border: generateBorder(),
        borderRadius: BorderRadius.circular(25),
      ),
      child: player == Mark.x
          ? Image.asset("assets/images/x.png", alignment: Alignment.center)
          : Image.asset("assets/images/o.png", alignment: Alignment.center),
    );
  }

  Border generateBorder() {
    BorderSide basicLine = BorderSide(
        color: const Color.fromARGB(255, 121, 116, 116).withOpacity(0.5),
        width: 1);
    BorderSide highligtedLine =
        const BorderSide(color: Color.fromARGB(255, 240, 192, 89), width: 1);
    return player == turn
        ? Border(
            left: highligtedLine,
            top: highligtedLine,
            right: highligtedLine,
            bottom: highligtedLine)
        : Border(
            left: basicLine,
            top: basicLine,
            right: basicLine,
            bottom: basicLine);
  }
}
