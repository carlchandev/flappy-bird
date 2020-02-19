import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flappy_bird/game.dart';
import 'package:flutter/material.dart';

const TextConfig scoreText =
    TextConfig(fontSize: 48.0, fontFamily: 'Awesome Font', color: Colors.white);

class Score {
  final FlappyBirdGame _game;
  int _score;

  Score(this._game, this._score);

  void render(Canvas c) {
    scoreText.render(c, '$_score', Position(_game.centerX - 15, 50));
  }

  void updateScore(int newScore) {
    _score = newScore;
  }
}
