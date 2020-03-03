import 'dart:ui';

import 'package:flame/components/text_component.dart';
import 'package:flame/time.dart';
import 'package:flappy_bird/config/game_text.dart';

class TopScore extends TextComponent {
  bool isDestroy = false;
  int score;
  final _countdown = Timer(1);

  bool _isVisible = false;

  TopScore(this.score)
      : super("Best: ${score.toString()}", config: GameText.regular) {
    _countdown.start();
  }

  @override
  void resize(Size s) {
    x = s.width / 2 - width / 2;
    y = s.height / 2 + 50;
  }

  @override
  void render(Canvas c) {
    if (_isVisible) {
      super.render(c);
    }
  }

  @override
  void update(double t) {
    if (_countdown.isRunning()) {
      _countdown.update(t);
    }
    if (_countdown.isFinished()) {
      _isVisible = true;
    }
  }

  void remove() => isDestroy = true;

  @override
  bool destroy() => isDestroy;

  @override
  int priority() => 30;
}
