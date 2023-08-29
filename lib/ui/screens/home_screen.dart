import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe_game/cubit/game_cubit.dart';
import 'package:tic_tac_toe_game/cubit/game_state.dart';
import 'package:tic_tac_toe_game/main.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final bloc = getIt.get<GameCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(state.turn.name.toString()),
            ),
            backgroundColor: const Color.fromARGB(255, 31, 30, 31),
            body: Center(
              child: BoardWidget(
                state: state,
                onPositionTap: (y, x) {
                  try {
                    bloc.placeMark(Position(y, x));
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
              ),
            ));
      },
    );
  }
}

class TurnLabelWidget extends StatelessWidget {
  const TurnLabelWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      bloc: getIt.get<GameCubit>(),
      builder: (context, state) {
        return Text(
          "${state.turn.name}'s turn",
          style: const TextStyle(color: Colors.black),
        );
      },
    );
  }
}

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
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        crossAxisCount: 3,
        children: List.generate(9, (index) {
          Mark tappedPositionMark =
              state.boardRepresentation[index ~/ 3][index % 3];
          return BoardButton(
            label: tappedPositionMark == Mark.empty
                ? ' '
                : tappedPositionMark.name,
            onTap: () => onPositionTap(index ~/ 3, index % 3),
          );
        }),
      ),
    );
  }
}

class BoardButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const BoardButton({super.key, required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          width: 2,
          color: const Color.fromARGB(255, 255, 255, 255),
        )),
        child: Center(
          child: Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 60)),
        ),
      ),
    );
  }
}
