import 'dart:ui';

import 'package:flame/components/text_component.dart';
import 'package:flappy_bird/config/game_text.dart';
import 'package:flutter/material.dart';

class GameOver extends TextComponent {
  bool _isVisible = false;
  double _toY;

  GameOver() : super('Game Over', config: GameText.large);

  @override
  void resize(Size s) {
    x = s.width / 2 - width / 2;
    y = -height;
    _toY = s.height * 1 / 3;
  }

  @override
  void render(Canvas c) {
    if (_isVisible) {
      super.render(c);
    }
  }

  @override
  void update(double t) {
    if (_isVisible && y <= _toY) {
      y += 6;
    }
  }

  void show() => _isVisible = true;

  void hide() {
    _isVisible = false;
    y = -height;
  }

  @override
  int priority() => 30;
}
