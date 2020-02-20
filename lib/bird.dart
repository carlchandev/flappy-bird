import 'dart:math';
import 'dart:ui';

import 'package:flame/animation.dart' as fa;
import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flappy_bird/game.dart';
import 'package:flappy_bird/sound.dart';

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
  double velocity = -2.3;
  double gravityAcceleration = 0.35;
  double timeCount = 0;
  double displacement;

  bool _isDead = false;

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
    }
  }

  void flap() {
    _birdAnimation.update(_stepTime);
  }

  void move(double t) {
    if (_isDead) {
      timeCount = timeCount < 10? 10: timeCount;
    }
    displacement = (velocity * timeCount) +
        (0.5 * gravityAcceleration * pow(timeCount, 2));
    if (timeCount < 19) {
      timeCount += 0.6;
    }
  }

  void jump() {
    if (!_isDead) {
      Flame.audio.play(Sound.jump, volume: 0.2);
      timeCount = 0;
    }
  }

  void die() {
    Flame.audio.play(Sound.die);
    _isDead = true;
  }

  bool isDead() => _isDead;
}
