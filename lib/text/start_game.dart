import 'dart:ui';

import 'package:flame/components/text_component.dart';
import 'package:flutter/material.dart';

import 'package:flappy_bird/config/game_text.dart';

class StartGame extends TextComponent {
  bool isVisible = true;

  StartGame() : super('Flappy Bird', config: GameText.large);

  @override
  void resize(Size s) {
    x = s.width / 2 - width/2;
    y = s.height / 2 - 250;
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
