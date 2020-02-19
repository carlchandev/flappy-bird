import 'dart:async';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/background.dart';
import 'package:flappy_bird/base.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flappy_bird/pipe.dart';
import 'package:flappy_bird/score.dart';
import 'package:flutter/material.dart';

import 'game_state.dart';

class FlappyBirdGame extends BaseGame {
  GameState gameState = GameState.initializing;
  Size screenSize;
  double width;
  double height;
  double centerX;
  double centerY;
  double skyTop = 0;
  double groundHeight;
  double tileSize;

  int _frameCount;
  Background _bg;
  Base _base;
  final int _pipeIntervalInMs = 1700;
  int _pipeCount;
  List<Pipe> _pipes = [];
  Set<int> _passedPipeIds = new Set();
  double _lastPipeInterval;
  Timer pipeFactoryTimer;
  Bird _bird;
  Score _score;

  void _initializeGame() {
    print('fired _initializeGame');
    _bg = Background(this);
    _base = Base(this);
    _bird = Bird(this);
    _score = Score(this, 0);
    _pipeCount = 0;
    _frameCount = 0;
    _pipes = [];
    _lastPipeInterval = 0;
    _passedPipeIds = new Set();
  }

  void _playGame() {
    gameState = GameState.playing;
  }

  void _pauseGame() {
    gameState = GameState.paused;
  }

  void _finishGame() {
    gameState = GameState.finished;
  }

  @override
  void render(Canvas c) {
    _bg?.render(c);
    _pipes?.forEach((p) => p.render(c));
    _base?.render(c);
    _bird?.render(c);
    _score.render(c);
  }

  @override
  void resize(Size s) {
    print("game.resize fired!");
    if (GameState.initializing == gameState) {
      super.resize(s);
      screenSize = s;
      tileSize = (s.width / 8).round().roundToDouble();
      groundHeight = tileSize * 2.5;
      width = s.width;
      height = s.height - groundHeight;
      centerX = s.width / 2;
      centerY = (s.height - groundHeight) / 2;

      print('screenSize: ${s.width} x ${s.height}');
      print('tileSize: $tileSize');
      print('center: ($centerX, $centerY)');
      print('game width, height: ($width, $height)');
      print('skyTop: $skyTop');
      print('groundHeight: $groundHeight');

      _initializeGame();
      gameState = GameState.start;
    } else {
      // todo resize screen?
    }
  }

  @override
  void update(double t) {
    if (GameState.playing == gameState) {
      _updateScore();
      _updatePipes(t);
      _updateBirds(t);
      _tickFrameCount();
    } else {
      return;
    }
  }

  void _updateScore() {
    _pipes
        .where((p) => p.isPassed())
        .forEach((p) => _passedPipeIds.add(p.pipeId));
    _score.updateScore(_passedPipeIds.length);
  }

  void _tickFrameCount() {
    _frameCount++;
    _frameCount = (_frameCount > 59) ? 0 : _frameCount;
  }

  void _updateBirds(double t) {
    if (_frameCount % 5 == 0) {
      _bird.flap();
    }
    _bird.move(t);
    _bird?.update(t);
  }

  void _updatePipes(double t) {
    if (_lastPipeInterval > _pipeIntervalInMs) {
      _pipes.add(Pipe(_pipeCount++, this));
      _lastPipeInterval = 0;
    } else {
      _lastPipeInterval += t * 1000;
    }
    _pipes = _pipes.where((p) => !p.isOutOfSight).toList();
    _pipes.forEach((p) => p.move());
    _pipes.forEach((p) => p.update(t));
  }

  @override
  void onTapDown(TapDownDetails details) {
    switch (gameState) {
      case GameState.playing:
        {
          _bird.jump();
//          _pauseGame();
        }
        break;
      case GameState.start:
      case GameState.paused:
        {
          _playGame();
        }
        break;
      default:
        {
          print('not handled.');
        }
        break;
    }
  }
}
