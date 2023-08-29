import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/cubit/game_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe_game/ui/router/app_router.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<GameCubit>(GameCubit(), signalsReady: true);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameCubit>(
      create: (context) => getIt.get<GameCubit>(),
      child: MaterialApp(
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
