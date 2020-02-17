import 'dart:ui';

import 'package:flame/animation.dart' as fa;
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flappy_bird/game.dart';
import 'package:flappy_bird/renderable.dart';

class Bird implements Renderable {
  static final List<fa.Frame> birdFrames = [0, 1, 2]
      .map((i) => new fa.Frame(new Sprite('bird$i.png'), 0.01))
      .toList();
  final animation = new fa.Animation(birdFrames);
  final FlappyBirdGame game;
  final double _width = 68.0;
  final double _height = 48.0;
  PositionComponent _bird;
  double x;
  double y;

  Bird(this.game, this.x, this.y) {
    _bird = AnimationComponent(_width, _height, animation);
  }

  @override
  void render(Canvas c) {
    _bird
      ..setByPosition(Position(x - (_width / 2), y - (_height / 2)))
      ..render(c);
  }

  @override
  void update(double t) {
    animation.update(t);
  }

  @override
  void resize(Size size) {}
}
