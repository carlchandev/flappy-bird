import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flappy_bird/game_controller.dart';

class Base extends SpriteComponent {
  Base() : super.fromSprite(100, 100, Sprite('base.png'));

  @override
  void resize(Size s) {
    x = 0;
    y = s.height - GameController.groundHeight;
    width = s.width;
    height = GameController.groundHeight;
  }

  @override
  int priority() => 30;
}
