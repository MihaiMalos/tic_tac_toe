import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/ui/screens/difficulty_screen/difficulty_screen.dart';
import 'package:tic_tac_toe_game/ui/screens/game_screen/view/game_screen.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const DifficultyScreen());
      case '/home':
        final strategy = routeSettings.arguments as Strategy;
        return MaterialPageRoute(
            builder: (_) => GameScreen(gameStrategy: strategy));
      default:
        throw Exception("The route name is not valid");
    }
  }
}
