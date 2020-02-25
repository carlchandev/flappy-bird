import 'dart:ui';

import 'package:flame/components/text_component.dart';
import 'package:flutter/material.dart';

import 'package:flappy_bird/config/game_text.dart';

class StartGame extends TextComponent {
  bool isVisible = true;

  StartGame() : super('Tap to start', config: GameText.light);

  @override
  void resize(Size s) {
    x = s.width / 2 - 70;
    y = s.height / 2 - 100;
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
}
