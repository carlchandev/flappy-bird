import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flappy_bird/game.dart';
import 'package:flappy_bird/renderable.dart';

class Base implements Renderable {
  final FlappyBirdGame game;
  Sprite _base = Sprite('base.png');
  Rect _baseRect;

  Base(this.game) {
    _baseRect = Rect.fromLTWH(0, game.screenSize.height - (game.tileSize * 2),
        game.screenSize.width, game.tileSize * 2);
  }

  @override
  void render(Canvas c) {
    _base?.renderRect(c, _baseRect);
  }

  @override
  void resize(Size s) {}

  @override
  void update(double t) {}
}
