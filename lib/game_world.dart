import 'package:flame/box2d/box2d_component.dart';
import 'package:flappy_bird/background/base.dart';
import 'package:flutter/gestures.dart';

import 'bird/bird.dart';

class GameWorld extends Box2DComponent {
  Bird _bird;

  GameWorld() : super(scale: 1.0, gravity: -10.0);

  @override
  void initializeWorld() {
//    add(Base(this));
    add(_bird = Bird(this));
  }

  @override
  void update(t) {
    super.update(t);
  }

  void onTapDown(TapDownDetails details) {
    _bird.onTapDown(details);
  }
}
