import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flappy_bird/game.dart';

class Base extends SpriteComponent {
  Base() : super.fromSprite(100, 100, Sprite('base.png'));

  @override
  void resize(Size s) {
    x = 0;
    y = s.height - FlappyBirdGame.groundHeight;
    width = s.width;
    height = FlappyBirdGame.groundHeight;
  }
}
