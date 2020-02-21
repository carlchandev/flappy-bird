import 'dart:async';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/background.dart';
import 'package:flappy_bird/base.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flappy_bird/pipe.dart';
import 'package:flappy_bird/score.dart';
import 'package:flappy_bird/sound.dart';
import 'package:flappy_bird/start_game.dart';
import 'package:flutter/material.dart';

import 'game_over.dart';
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
  StartGame _startGame;
  GameOver _gameOver;
  bool _hasCrashed;

  FlappyBirdGame() {
    Flame.audio.loadAll([
      Sound.bgm,
      Sound.jump,
      Sound.die,
      Sound.crash,
    ]);
  }

  @override
  bool debugMode() => true;

  void _initializeGame() {
    print('fired _initializeGame');
    initializeBgm();
    _bg = Background(this);
    _base = Base(this);
    _bird = Bird(this);
    _startGame = StartGame(this);
    _gameOver = GameOver(this);
    _score = Score(this, 0);
    _pipeCount = 0;
    _frameCount = 0;
    _pipes = [];
    _lastPipeInterval = 1400;
    _passedPipeIds = new Set();
    _hasCrashed = false;
  }

  void initializeBgm() {
    if (!Flame.bgm.isPlaying) {
      Flame.bgm.play(Sound.bgm, volume: 0.5);
    }
  }

  void _playGame() {
    gameState = GameState.playing;
  }

  void _pauseGame() {
    gameState = GameState.paused;
  }

  @override
  void render(Canvas c) {
    _bg?.render(c);
    _pipes?.forEach((p) => p.render(c));
    _base?.render(c);
    if (gameState == GameState.start) {
      _startGame?.render(c);
    }
    if (gameState == GameState.finished) {
      _gameOver?.render(c);
    }
    _bird?.render(c);
    _score?.render(c);
  }

  @override
  void resize(Size s) {
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
    }
  }

  @override
  void update(double t) {
    if (GameState.playing == gameState) {
      if (!_hasCrashed && _isCrashing()) {
        gameOver();
      } else {
        _updateScore();
        _updatePipes(t);
      }
      _updateBirds(t);
      _tickFrameCount();
    } else if (GameState.finished == gameState) {
      _updateBirds(t);
      _tickFrameCount();
    } else {
      return;
    }
  }

  void gameOver() {
    _hasCrashed = true;
    Flame.audio.play(Sound.crash);
    _bird.die();
    Flame.bgm.stop();
    gameState = GameState.finished;
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
    if (!_bird.isDead() && _frameCount % 5 == 0) {
      _bird.flap();
    }
    _bird.move(t);
    _bird.update(t);
  }

  bool _isCrashing() {
    if (_bird.isDead() || _hasCrashed) return false;
    if (_bird.y < 0 || _bird.y > (height - Bird.height)) {
      return true;
    }
    final _comingPipes = _pipes.where((p) => !p.isPassed());
    print('bird ${_bird.x}, ${_bird.y}');
    // todo add crash box to debug
    for (Pipe p in _comingPipes) {
      print('=================');
      print('bird ${_bird.x}, ${_bird.y}');
      print('upperLTWH ${p.upperLTWH["x"]}, ${p.upperLTWH["height"]}');
      print('lowerLTWH ${p.lowerLTWH["x"]}, ${height - p.lowerLTWH["height"]}');
      print('=================');
      if (_bird.x + (Bird.height / 2) >=
              (p.upperLTWH['x'] - (Bird.height / 2)) &&
          _bird.x + (Bird.height / 2) <=
              p.upperLTWH['x'] + p.pipeWidth) {
        print('touch Pipe horizontally');
        if ((_bird.y - (Bird.height / 2)) <= p.upperLTWH['height'] ||
            (_bird.y + (Bird.height / 2)) >=
                (height - p.lowerLTWH['height'] - (Bird.height / 2))) {
          print('touch Pipe vertically');
          return true;
        }
      }
    }
    return false;
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
        }
        break;
      case GameState.start:
      case GameState.paused:
        {
          _playGame();
        }
        break;
      case GameState.finished:
        {
          _initializeGame();
          gameState = GameState.start;
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
