import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flappy_bird/game.dart';
import 'package:flutter/material.dart';

import 'game_text.dart';

class GameOver {
  final FlappyBirdGame _game;

  GameOver(this._game);

  void render(Canvas c) {
    GameText.large.render(
        c, 'Game Over', Position(_game.centerX - 135, _game.centerY - 80));
    GameText.light.render(
        c, 'Tap to retry', Position(_game.centerX - 75, _game.centerY + 50));
  }
}
