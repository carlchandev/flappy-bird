import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flappy_bird/game.dart';

class Base {
  final FlappyBirdGame game;
  Sprite _base = Sprite('base.png');
  Rect _baseRect;

  Base(this.game) {
    _baseRect = Rect.fromLTWH(0, game.screenSize.height - game.groundHeight,
        game.screenSize.width, game.groundHeight);
  }

  void render(Canvas c) {
    _base?.renderRect(c, _baseRect);
  }
}
