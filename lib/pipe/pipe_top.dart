import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flappy_bird/pipe/pipe.dart';

class PipeTop extends SpriteComponent {
  final double gapTopY;
  bool isDestroy = false;

  PipeTop(x, this.gapTopY)
      : super.fromSprite(
            Pipe.pipeWidth, Pipe.pipeHeight, Sprite('pipe-top.png')) {
    this.x = x;
  }

  @override
  void resize(Size s) {
    y = 0 - (height - gapTopY);
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
