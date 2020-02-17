import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flappy_bird/game.dart';
import 'package:flappy_bird/renderable.dart';
import 'package:flutter/material.dart';

class Background implements Renderable {
  final FlappyBirdGame game;
  Sprite _bg = Sprite('bg.png');
  Rect _bgRect;

  Background(this.game) {
    _bgRect =
        Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
  }

  @override
  void render(Canvas c) {
    Rect bg =
        Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
    Paint paint = Paint();
    paint.color = Colors.white;
    c.drawRect(bg, paint);
//    _bg?.renderRect(c, _bgRect);
  }

  @override
  void resize(Size s) {}

  @override
  void update(double t) {}
}
