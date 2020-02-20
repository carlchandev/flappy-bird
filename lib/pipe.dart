import 'dart:math';
import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flappy_bird/game.dart';

class Pipe {
  final int pipeId;
  final FlappyBirdGame game;

  Sprite _pipeUpper = Sprite('pipe_top.png');
  Sprite _pipeLower = Sprite('pipe_bottom.png');
  Rect _pipeUpperRect;
  Rect _pipeLowerRect;

  double _gapHeight;
  double _gapTopY;

  final double pipeWidth = 70;
  final double pipeFullHeight = 500;
  final int gapMinHeight = 180;
  final int gapMaxHeight = 240;
  final int gapMinTopY = 150;
  final int gapMaxTopY = 350;
  double _pipeX;
  double _pipeUpperTopY;
  double _pipeUpperHeight;
  double _pipeLowerTopY;
  double _pipeLowerHeight;

  bool isOutOfSight = false;

  Pipe(this.pipeId, this.game) {
    _pipeX = game.screenSize.width;
    _gapHeight = randomIntInRange(gapMinHeight, gapMaxHeight);
    _gapTopY = randomIntInRange(gapMinTopY, gapMaxTopY);
    _pipeUpperTopY = _gapTopY - pipeFullHeight;
    _pipeUpperHeight = pipeFullHeight;
    _pipeLowerTopY = _gapTopY + _gapHeight;
    _pipeLowerHeight = pipeFullHeight;
  }

  double randomIntInRange(int min, int max) {
    return (min + Random().nextInt(max - min)).toDouble();
  }

  void render(Canvas c) {
    _pipeUpperRect =
        Rect.fromLTWH(_pipeX, _pipeUpperTopY, pipeWidth, _pipeUpperHeight);
    _pipeLowerRect =
        Rect.fromLTWH(_pipeX, _pipeLowerTopY, pipeWidth, _pipeLowerHeight);
    _pipeUpper.renderRect(c, _pipeUpperRect);
    _pipeLower.renderRect(c, _pipeLowerRect);
  }

  void resize(Size s) {}

  void update(double t) {}

  void move() {
    if (_pipeX < -50) {
      isOutOfSight = true;
    } else {
      _pipeX -= 3;
    }
  }

  bool isPassed() => _pipeX < game.centerX - (Bird.width / 2);
}
