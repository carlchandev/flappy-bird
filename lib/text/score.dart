import 'dart:ui';

import 'package:flame/components/text_component.dart';

import 'package:flappy_bird/config/game_text.dart';

class Score extends TextComponent {
  Score() : super('0', config: GameText.large);

  @override
  void resize(Size s) {
    x = s.width / 2 - 13;
    y = 50;
  }

  void updateScore(int newScore) {
    text = newScore.toString();
    // todo: play a sound
  }
}
