import 'dart:ui';

import 'package:flame/components/text_component.dart';

import 'package:flappy_bird/config/game_text.dart';

class Score extends TextComponent {
  bool isVisible = false;

  Score() : super('0', config: GameText.large);

  @override
  void resize(Size s) {
    x = s.width / 2 - width / 2;
    y = 50;
  }

  @override
  void render(Canvas c) {
    if (isVisible) {
      super.render(c);
    }
  }

  void updateScore(int newScore) {
    text = newScore.toString();
    // todo: play a sound
  }

  void setVisible(bool isVisible) {
    this.isVisible = isVisible;
  }

  @override
  int priority() => 30;
}
