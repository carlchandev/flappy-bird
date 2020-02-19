import 'dart:math';
import 'dart:ui';

import 'package:flame/animation.dart' as fa;
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flappy_bird/game.dart';

class Bird {
  static final double _spriteWidth = 34;
  static final double _spriteHeight = 24;
  static final _scaleFactor = 1.5;
  static final double width = _spriteWidth * _scaleFactor;
  static final double height = _spriteHeight * _scaleFactor;

  static final double _stepTime = 0.02;

  static final List<Sprite> sprites = [0, 1, 2, 1]
      .map((i) =>
          Sprite('bird$i.png', width: _spriteWidth, height: _spriteHeight))
      .toList();
  final fa.Animation _birdAnimation =
      fa.Animation.spriteList(sprites, stepTime: _stepTime);
  final FlappyBirdGame game;
  double x;
  double y;
  double velocity = -2.5;
  double gravityAcceleration = 0.4;
  double timeCount = 0;
  double displacement;

  Bird(this.game) {
    x = game.centerX;
    y = game.centerY;
  }

  void render(Canvas c) {
    _birdAnimation.getSprite().renderPosition(
        c, Position(x - (width / 2), y + (height / 2)),
        size: Position(width, height));
  }

  void update(double t) {
    if (y < game.height - height) {
      y += displacement;
    } else {
      // god mode
      y -= 900;
    }
  }

  void flap() {
    _birdAnimation.update(_stepTime);
  }

  void move(double t) {
    displacement = (velocity * timeCount) +
        (0.5 * gravityAcceleration * pow(timeCount, 2));
    if (timeCount < 15) {
      timeCount++;
    }
  }

  void jump() {
    timeCount = 0;
  }
}
