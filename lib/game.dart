import 'package:flame/game.dart';
import 'package:flappy_bird/background.dart';
import 'package:flappy_bird/base.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flappy_bird/pipe.dart';
import 'package:flutter/material.dart';

class FlappyBirdGame extends BaseGame {
  Size screenSize;
  double centerX;
  double centerY;
  double tileSize;

  Background _bg;
  Base _base;
  Pipe _pipe;
  Bird _bird;

  @override
  void render(Canvas c) {
    _bg?.render(c);
    _base?.render(c);
    _pipe?.render(c);
    _bird?.render(c);
  }

  @override
  void resize(Size s) {
    super.resize(s);
    screenSize = s;
    centerX = screenSize.width / 2;
    centerY = screenSize.height / 2;
    tileSize = screenSize.height / 12;

    _bg = Background(this);
    _base = Base(this);
    _pipe = Pipe(this);
    _bird = Bird(this, centerX, centerY);
  }

  @override
  void update(double t) {
    _bg?.update(t);
    _base?.update(t);
    _pipe?.update(t);
    _bird?.update(t);
  }

  @override
  void onTapDown(TapDownDetails details) {
    print('on tapdown');
  }
}
