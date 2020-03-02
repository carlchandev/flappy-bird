import 'dart:math';
import 'dart:ui';

import 'package:flame/animation.dart' as fa;
import 'package:flame/components/animation_component.dart';
import 'package:flame/flame.dart';
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

  Bird(this._game)
      : super(51, 36, fa.Animation.spriteList(sprites, stepTime: 0.08));

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
//      if (y > 0) {
//        angle = flyAngles[flyAnimationIndex++];
//        if (flyAnimationIndex > flyAngles.length) {
//          flyAnimationIndex = 0;
//        }
//      }
      super.update(t);
    }
  }

  void _move() {
    if (isDead) {
      timeCount = timeCount < 10 ? 10 : timeCount;
    }
    displacement = (velocity * timeCount) +
        (0.5 * gravityAcceleration * pow(timeCount, 2));
    if (timeCount < 19) {
      timeCount += 0.6;
    }
    if (y < _game.height - height) {
      if (isDead && angle <= pi / 3) {
        angle += pi / 10;
      }
      y += displacement;
    }
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
  }

  @override
  bool destroy() => isDestroy;

  void remove() => isDestroy = true;

  @override
  int priority() => 28;
}
