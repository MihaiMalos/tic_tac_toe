import 'package:tic_tac_toe_game/GameLib/src/enums/game_state.dart';

abstract interface class GameObserver {
  void onPlaceMark();
  void onGameOver(GameState state);
}