import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/ui/screens/difficulty_screen.dart';
import 'package:tic_tac_toe_game/ui/screens/home_screen/home_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const DifficultyScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        throw Exception("The route name is not valid");
    }
  }
}
