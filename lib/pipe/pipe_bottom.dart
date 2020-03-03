import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flappy_bird/game.dart';
import 'package:flappy_bird/pipe/pipe.dart';

class PipeBottom extends SpriteComponent {
  final double gapTopY;
  final double gapHeight;
  bool isDestroy = false;

  PipeBottom(x, this.gapTopY, this.gapHeight)
      : super.fromSprite(
            Pipe.pipeWidth, Pipe.pipeHeight, Sprite('pipe-bottom.png')) {
    this.x = x;
  }

  @override
  void resize(Size s) {
    y = gapTopY + gapHeight;
    super.resize(s);
  }

  void move(double x) {
    this.x = x;
  }

  @override
  bool destroy() => isDestroy;

  void remove() => isDestroy = true;

  @override
  int priority() => 25;
}
