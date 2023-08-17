import 'package:tic_tac_toe/src/interfaces/iposition.dart';

class Position implements IPosition {
  final int _x, _y;

  Position(this._x, this._y);

  @override
  bool isValid() {
    return _x > 0 && _x < 3 && _y > 0 && _y < 3;
  }
}
