import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:tic_tac_toe_game/screens/game_screen/cubit/game_cubit.dart';
import 'package:tic_tac_toe_game/router/app_router.dart';

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _appRouter.onGenerateRoute,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: const Color.fromARGB(0, 0, 0, 0),
        background: const Color.fromARGB(255, 31, 30, 31),
        primary: const Color.fromARGB(255, 240, 192, 89),
      )),
    );
  }
}
