import 'dart:math';
import 'dart:ui';

import 'package:flame/animation.dart' as fa;
import 'package:flame/components/animation_component.dart';
import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flappy_bird/config/sound.dart';
import 'package:flappy_bird/game.dart';

import '../game_state.dart';

class Bird extends AnimationComponent {
  static final List<Sprite> sprites =
      [0, 1, 2, 1].map((i) => Sprite('bird$i.png')).toList();
  final FlappyBirdGame _game;

  double velocity = -2.3;
  double gravityAcceleration = 0.35;
  double timeCount = 0;
  double displacement;
  bool isDead = false;
  bool isDestroy = false;
  List<double> flyAngles = [-pi / 10, -pi / 8, -pi / 6];
  int flyAnimationIndex = 0;

  Paint paint = Paint();

  Bird(this._game)
      : super(51, 36, fa.Animation.spriteList(sprites, stepTime: 0.08)) {
    paint.color = debugColor;
    paint.style = PaintingStyle.stroke;
  }

  @override
  void resize(Size s) {
    x = s.width / 2 - width / 2;
    y = s.height / 2 - 50;
    super.resize(s);
  }

  @override
  void update(double t) {
    if (_game.gameState == GameState.playing || isDead) {
      _move();
    }
    if (!isDead) {
      super.update(t);
    }
  }

  void _move() {
    if (isDead) {
      return; // debug
      timeCount = timeCount < 10 ? 10 : timeCount;
    }
    displacement = (velocity * timeCount) +
        (0.5 * gravityAcceleration * pow(timeCount, 2));
    if (timeCount < 19) {
      timeCount += 0.6;
    }
    if (y < _game.height - height) {
      if (isDead) {
        angle = pi / 2;
      }
      y += displacement;
    }
//    if (displacement < 0) {
//      angle = flyAngles[flyAnimationIndex++];
//      if (flyAnimationIndex > flyAngles.length) {
//        flyAnimationIndex = 0;
//      }
//    }
  }

  void jump() {
    if (!isDead) {
      Flame.audio.play(Sound.jump, volume: 0.5);
      timeCount = 0;
      flyAnimationIndex = 0;
    }
  }

  void die() {
    Flame.audio.play(Sound.die);
    isDead = true;
//    x += width;
  }

  @override
  bool destroy() => isDestroy;

  void remove() => isDestroy = true;

  @override
  int priority() => 28;

  @override
  void renderDebugMode(Canvas canvas) {
    // draw bird circle
    final dx = width / 2;
    final dy = height / 2;
    final radius = height * 3/5;
    canvas.drawCircle(Offset(dx, dy), radius, paint);
    debugTextConfig.render(
        canvas,
        "(${dx.toStringAsFixed(2)}, ${dy.toStringAsFixed(2)}) r:${radius.toStringAsFixed(2)}",
        Position(width - 50, height));
    // draw center
    canvas.drawPoints(PointMode.points, [Offset(dx, dy)], paint);
    debugTextConfig.render(
        canvas,
        "(${dx.toStringAsFixed(2)}, ${dy.toStringAsFixed(2)})",
        Position(-dx, dy - 40));
  }
}
