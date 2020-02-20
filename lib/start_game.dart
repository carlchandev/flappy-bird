import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flappy_bird/game.dart';
import 'package:flutter/material.dart';

import 'game_text.dart';

class StartGame {
  final FlappyBirdGame _game;

  StartGame(this._game);

  void render(Canvas c) {
    GameText.light.render(
        c, 'Tap to start', Position(_game.centerX - 70, _game.centerY - 30));
  }
}
