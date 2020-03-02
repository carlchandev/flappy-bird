import 'dart:ui';

import 'package:flame/components/text_component.dart';
import 'package:flutter/material.dart';

import 'package:flappy_bird/config/game_text.dart';

class GameOver extends TextComponent {
  bool isVisible = false;

  GameOver() : super('Game Over\nTap to retry', config: GameText.regular);

  @override
  void resize(Size s) {
    x = s.width / 2 - 80;
    y = s.height / 2 - 130;
  }

  @override
  void render(Canvas c) {
    if (isVisible) {
      super.render(c);
    }
  }

  void setVisible(bool isVisible) {
    this.isVisible = isVisible;
  }

  @override
  int priority() => 30;
}
