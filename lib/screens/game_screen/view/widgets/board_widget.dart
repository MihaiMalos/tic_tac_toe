import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/screens/game_screen/cubit/game_state.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class BoardWidget extends StatelessWidget {
  final GameState state;
  final Function(int x, int y) onPositionTap;

  const BoardWidget({
    super.key,
    required this.state,
    required this.onPositionTap,
  });
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 250),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        crossAxisCount: 3,
        children: List.generate(9, (index) {
          Mark tappedPositionMark =
              state.boardRepresentation[index ~/ 3][index % 3];
          return BoardButton(
              image: tappedPositionMark == Mark.empty
                  ? Image.asset("assets/images/empty.png")
                  : Image.asset(
                      "assets/images/${tappedPositionMark.name}.png",
                      opacity: const AlwaysStoppedAnimation(0.7),
                      width: 60,
                    ),
              onTap: () => onPositionTap(index ~/ 3, index % 3),
              border: generateBorder(index));
        }),
      ),
    );
  }

  Border generateBorder(int index) {
    const BorderSide borderLine = BorderSide(
      width: 1,
      color: Color.fromARGB(128, 255, 255, 255),
    );
    switch (index) {
      case 0:
        return const Border(bottom: borderLine, right: borderLine);
      case 1:
        return const Border(
            left: borderLine, bottom: borderLine, right: borderLine);
      case 2:
        return const Border(left: borderLine, bottom: borderLine);
      case 3:
        return const Border(
            bottom: borderLine, right: borderLine, top: borderLine);
      case 5:
        return const Border(
            left: borderLine, bottom: borderLine, top: borderLine);
      case 6:
        return const Border(right: borderLine, top: borderLine);
      case 7:
        return const Border(
            left: borderLine, top: borderLine, right: borderLine);
      case 8:
        return const Border(left: borderLine, top: borderLine);
      default:
        return const Border(
            left: borderLine,
            bottom: borderLine,
            right: borderLine,
            top: borderLine);
    }
  }
}

class BoardButton extends StatelessWidget {
  final Image image;
  final VoidCallback onTap;
  final Border border;

  const BoardButton(
      {super.key,
      required this.image,
      required this.onTap,
      required this.border});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: border,
          ),
          child: Center(
            child: image,
          ),
        ));
  }
}
