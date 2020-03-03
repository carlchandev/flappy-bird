import 'dart:ui';

import 'package:flame/components/text_component.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird/config/game_text.dart';
import 'package:flappy_bird/config/sound.dart';

class Score extends TextComponent {
  bool isVisible = false;
  int score;

  Score(this.score) : super(score.toString(), config: GameText.large);

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
    if (newScore > score) {
      Flame.audio.play(Sound.score, volume: 0.5);
    }
    score = newScore;
    text = score.toString();
  }

  void reset() {
    score = 0;
  }

  void setVisible(bool isVisible) {
    this.isVisible = isVisible;
  }

  @override
  int priority() => 30;
}
