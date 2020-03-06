import 'dart:math';
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/animation.dart' as fa;
import 'package:flame/components/animation_component.dart';
import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flappy_bird/config/sound.dart';
import 'package:flappy_bird/game_controller.dart';

import '../game_state.dart';

class Bird extends AnimationComponent {
  static final List<Sprite> sprites =
      [0, 1, 2, 1].map((i) => Sprite('bird$i.png')).toList();
  final GameController _game;
  bool isDead = false;
  double radius;

  double _velocity = -2.3;
  double _gravityAcceleration = 0.34;
  double _displacement;
  bool _isDestroy = false;
  double _timeCount = 0;
  double _initialJumpSpeed = 3.5;
  double _initialDropSpeed = 5;
  double _maxDropSpeed = 17.5;
  double _dropAcceleration = 0.55;

  Paint paint = Paint();

  Bird(this._game)
      : super(51, 36, fa.Animation.spriteList(sprites, stepTime: 0.08)) {
    anchor = Anchor.center;
    paint.color = debugColor;
    paint.style = PaintingStyle.stroke;
  }

  @override
  void resize(Size s) {
    x = s.width / 2;
    y = (s.height - GameController.groundHeight) / 2;
    radius = height * 3 / 5;
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
      _timeCount =
          _timeCount < _initialDropSpeed ? _initialDropSpeed : _timeCount;
    }
    _calculateDisplacement();
    _limitDropAcceleration();
    _applyDisplacement();
    _spin();
  }

  void _applyDisplacement() {
    if (y < _game.height - height / 2) {
      y += (_displacement * 0.75);
    }
  }

  void _limitDropAcceleration() {
    if (_timeCount < _maxDropSpeed) {
      _timeCount += _dropAcceleration;
    }
  }

  void _calculateDisplacement() {
    _displacement = (_velocity * _timeCount) +
        (0.5 * _gravityAcceleration * pow(_timeCount, 2));
  }

  void _spin() {
    if (_displacement < 0) {
      angle = -pi / 8;
    } else if (_displacement == 0) {
      angle = 0;
    } else if (_displacement > 0 && _displacement <= 10.91) {
      angle = pi / 8;
    } else {
      angle = pi / 3;
    }
    if (isDead) {
      angle = pi / 2;
    }
  }

  void jump() {
    if (!isDead) {
      Flame.audio.play(Sound.jump, volume: 0.5);
      _timeCount = _initialJumpSpeed;
    }
  }

  void die() {
    Flame.audio.play(Sound.die, volume: 0.5);
    isDead = true;
  }

  @override
  bool destroy() => _isDestroy;

  void remove() => _isDestroy = true;

  @override
  int priority() => 28;

  @override
  void renderDebugMode(Canvas canvas) {
    canvas.drawCircle(Offset(width / 2, height / 2), radius, paint);
    canvas.drawPoints(PointMode.points, [Offset(x, y)], paint);
    debugTextConfig.render(
        canvas,
        "(${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)}) r:${radius.toStringAsFixed(2)}",
        Position(width - 50, height));
  }
}
