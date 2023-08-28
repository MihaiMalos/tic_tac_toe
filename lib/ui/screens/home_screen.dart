import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe_game/cubit/game_cubit.dart';
import 'package:tic_tac_toe_game/cubit/game_state.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: BoardWidget(),
      ),
    );
  }
}

class TurnLabelWidget extends StatelessWidget {
  const TurnLabelWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, TicTacToeState>(
      builder: (context, state) {
        if (state is GameContinueState) {
          return Text(
            "${state.turn.name}'s turn",
            style: const TextStyle(color: Colors.black),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class BoardWidget extends StatelessWidget {
  const BoardWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(9, (index) {
          return BoardButton(row: index ~/ 3, column: index % 3);
        }),
      ),
    );
  }
}

class BoardButton extends StatelessWidget {
  final int row, column;
  const BoardButton({super.key, required this.row, required this.column});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<GameCubit, TicTacToeState>(
        builder: (context, state) {
          if (state is GameContinueState) {
            Mark currentMark = state.boardRepresentation[row][column];
            return Text(
              currentMark == Mark.empty ? 'E' : currentMark.name.toUpperCase(),
              style: const TextStyle(color: Colors.black),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
