import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flappy_bird/game.dart';
import 'package:flutter/material.dart';

class Background {
  final FlappyBirdGame game;
  Sprite _bg = Sprite('bg.png');
  Rect _bgRect;
  int count = 0;

  Background(this.game) {
    _bgRect =
        Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
  }

  void render(Canvas c) {
    _bg?.renderRect(c, _bgRect);
  }
}
