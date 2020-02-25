import 'dart:math';

import 'package:flappy_bird/bird/bird.dart';
import 'package:flappy_bird/game.dart';
import 'package:flappy_bird/pipe/pipe_bottom.dart';
import 'package:flappy_bird/pipe/pipe_top.dart';

class Pipe {
  static final double speed = 3;
  static final double pipeWidth = 70;
  static final double pipeHeight = 500;

  final int pipeId;
  final FlappyBirdGame _game;

  PipeTop pipeTop;
  PipeBottom pipeBottom;

  double _gapHeight;
  double _gapTopY;

  final int gapMinHeight = 180;
  final int gapMaxHeight = 240;
  final int gapMinTopY = 150;
  final int gapMaxTopY = 350;
  double x;
  bool isOutOfSight = false;

  Pipe(this.pipeId, this._game, startX) {
    x = startX;
    _gapHeight = _randomIntInRange(gapMinHeight, gapMaxHeight);
    _gapTopY = _randomIntInRange(gapMinTopY, gapMaxTopY);
    pipeTop = PipeTop(x, _gapTopY);
    pipeBottom = PipeBottom(x, _gapTopY, _gapHeight);
  }

  Map get upperLTWH => {
        "x": x,
        "height": _gapTopY,
      };

  Map get lowerLTWH => {
        "x": x,
        "height": _game.height - _gapTopY - _gapHeight,
      };

  double _randomIntInRange(int min, int max) {
    return (min + Random().nextInt(max - min)).toDouble();
  }

  void move() {
    if (x < -100) {
      isOutOfSight = true;
    } else {
      x -= speed;
      pipeTop.move(x);
      pipeBottom.move(x);
    }
  }

  bool isPassed(Bird bird) => (x + pipeWidth) < bird.x;

  void destroy() {
    pipeTop.remove();
    pipeBottom.remove();
  }
}
