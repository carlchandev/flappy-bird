import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/sprite.dart';
import 'package:flame/time.dart';
import 'package:flutter/gestures.dart';

class RetryButton extends SpriteComponent with Tapable {
  bool isDestroy = false;
  Function tapCallback;
  final _countdown = Timer(1.5);
  bool _isVisible = false;

  RetryButton(this.tapCallback)
      : super.fromSprite(60, 60, Sprite("play-btn.png")) {
    _countdown.start();
  }

  @override
  void resize(Size s) {
    x = s.width / 2 - width / 2;
    y = s.height * 2 / 3;
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

  @override
  void onTapUp(TapUpDetails details) {
    tapCallback();
  }

  @override
  bool destroy() => isDestroy;

  void remove() => isDestroy = true;

  @override
  int priority() => 35;
}
