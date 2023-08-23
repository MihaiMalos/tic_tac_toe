import 'package:flutter/material.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

void main() {
  Game g;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: const BoardWidget(),
      ),
    );
  }
}

class BoardWidget extends StatelessWidget {
  const BoardWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(9, (index) {
        return const Center(
          child: Text(
            '1',
            style: TextStyle(color: Colors.white),
          ),
        );
      }),
    );
  }
}
