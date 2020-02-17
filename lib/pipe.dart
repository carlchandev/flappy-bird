import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flappy_bird/game.dart';
import 'package:flappy_bird/renderable.dart';

class Pipe implements Renderable {
  final FlappyBirdGame game;
  Sprite _pipeTop = Sprite('pipe_top.png');
  Sprite _pipeBottom = Sprite('pipe_bottom.png');
  double x;
  Rect _pipeTopRect;
  Rect _pipeBottomRect;
  bool isOutOfSight = false;

  Pipe(this.game) {
    x = game.screenSize.width;
  }

  @override
  void render(Canvas c) {
    _pipeTopRect = Rect.fromLTWH(x, 0, game.tileSize, game.tileSize * 2);
    _pipeBottomRect = Rect.fromLTWH(
        x,
        game.screenSize.height - game.tileSize * 4,
        game.tileSize,
        game.tileSize * 2);
    _pipeTop.renderRect(c, _pipeTopRect);
    _pipeBottom.renderRect(c, _pipeBottomRect);
  }

  @override
  void resize(Size s) {}

  @override
  void update(double t) {
    if (x < -50) {
      isOutOfSight = true;
    } else {
      x -= game.tileSize;
    }
  }
}
