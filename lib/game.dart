import 'dart:async';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/background/background.dart';
import 'package:flappy_bird/config/sound.dart';
import 'package:flappy_bird/game_world.dart';
import 'package:flappy_bird/pipe/pipe.dart';
import 'package:flappy_bird/text/game_over.dart';
import 'package:flappy_bird/text/score.dart';
import 'package:flappy_bird/text/start_game.dart';
import 'package:flutter/material.dart';

import 'game_state.dart';

class FlappyBirdGame extends BaseGame {
  final GameWorld world = GameWorld();

  static final double groundHeight = 130;

  GameState gameState = GameState.initializing;
  Size screenSize;
  double width;
  double height;
  double centerX;
  double centerY;
  double skyTop = 0;

  Background _bg = Background();
  final int _pipeIntervalInMs = 1800;
  int _pipeCount;
  List<Pipe> _pipes = [];
  Set<int> _passedPipeIds = new Set();
  double _lastPipeInterval;
  Timer pipeFactoryTimer;
  Score _score = Score();
  StartGame _startGame = StartGame();
  GameOver _gameOver = GameOver();
  bool _hasCrashed;

  @override
  bool debugMode() {
    return true;
  }

  FlappyBirdGame() {
    world.initializeWorld();
    Flame.audio.loadAll([
      Sound.bgm,
      Sound.jump,
      Sound.die,
      Sound.crash,
    ]);
    add(_bg);
//    add(_score);
//    add(_startGame);
//    add(_gameOver);
  }

  @override
  void resize(Size s) {
    super.resize(s);
    world.resize(s);
    if (GameState.initializing == gameState) {
      screenSize = s;
      width = s.width;
      height = s.height - groundHeight;
      centerX = s.width / 2;
      centerY = (s.height - groundHeight) / 2;

      print('game: screenSize: ${s.width} x ${s.height}');
      print('game: center: ($centerX, $centerY)');
      print('game: width, height: ($width, $height)');
      print('game: skyTop: $skyTop');
      print('game: groundHeight: $groundHeight');

      _gotoStartGame();
    }
  }

  void _initializeGame() {
    print('fired _initializeGame');
//    _initializeBgm();
    _score.updateScore(0);
    _initializePipes();

    _hasCrashed = false;
  }

  void _initializePipes() {
    _pipes.forEach((p) => p.destroy());
    _pipes = [];
    _pipeCount = 0;
    _passedPipeIds = new Set();
    _lastPipeInterval = 1400;
  }

  void _initializeBgm() {
    if (!Flame.bgm.isPlaying) {
      Flame.bgm.play(Sound.bgm, volume: 0.5);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    world.render(canvas);
  }

  @override
  void update(double t) {
    super.update(t);
    world.update(t);
    if (GameState.playing == gameState) {
      _updatePipes(t);
//      if (!_hasCrashed && _isCrashing()) {
//        _gotoGameOver();
//      } else {
//        _updateScore();
//      }
    }
  }

//  void _updateScore() {
//    _pipes
//        .where((p) => p.isPassed(_bird))
//        .forEach((p) => _passedPipeIds.add(p.pipeId));
//    _score.updateScore(_passedPipeIds.length);
//  }

//  bool _isCrashing() {
//    if (_bird.isDead || _hasCrashed) return false;
//    if (_bird.y < 0 || _bird.y > (height - _bird.height)) {
//      return true;
//    }
//    final _comingPipes = _pipes.where((p) => !p.isPassed(_bird));
//    print('bird ${_bird.x}, ${_bird.y}');
//    // todo add crash box to debug
//    for (Pipe p in _comingPipes) {
//      print('=================');
//      print('bird ${_bird.x}, ${_bird.y}');
//      print('upperLTWH ${p.upperLTWH["x"]}, ${p.upperLTWH["height"]}');
//      print('lowerLTWH ${p.lowerLTWH["x"]}, ${height - p.lowerLTWH["height"]}');
//      print('=================');
//      if (_bird.x + (_bird.height / 2) >=
//              (p.upperLTWH['x'] - (_bird.height / 2)) &&
//          _bird.x + (_bird.height / 2) <= p.upperLTWH['x'] + Pipe.pipeWidth) {
//        print('touch Pipe horizontally');
//        if ((_bird.y - (_bird.height / 2)) <= p.upperLTWH['height'] ||
//            (_bird.y + (_bird.height / 2)) >=
//                (height - p.lowerLTWH['height'] - (_bird.height / 2))) {
//          print('touch Pipe vertically');
//          return true;
//        }
//      }
//    }
//    return false;
//  }

  void _updatePipes(double t) {
    if (_lastPipeInterval > _pipeIntervalInMs) {
      Pipe pipe = Pipe(_pipeCount++, this, width);
      add(pipe.pipeTop);
      add(pipe.pipeBottom);
      _pipes.add(pipe);
      _lastPipeInterval = 0;
    } else {
      _lastPipeInterval += t * 1000;
    }
    _pipes.forEach((p) {
      p.isOutOfSight ? p.destroy() : p.move();
    });
    _pipes = _pipes.where((p) => !p.isOutOfSight).toList();
  }

  @override
  void onTapDown(TapDownDetails details) {
    world.onTapDown(details);
    switch (gameState) {
      case GameState.playing:
        {
//          _bird.jump();
        }
        break;
      case GameState.start:
      case GameState.paused:
        {
          _gotoPlayGame();
        }
        break;
      case GameState.finished:
        {
          _gotoStartGame();
        }
        break;
      default:
        {
          print('not handled.');
        }
        break;
    }
  }

  void _gotoStartGame() {
    _gameOver.setVisible(false);
    _initializeGame();
    gameState = GameState.start;
  }

  void _gotoPlayGame() {
    gameState = GameState.playing;
    _startGame.setVisible(false);
  }

  void _pauseGame() {
    gameState = GameState.paused;
  }

  void _gotoGameOver() {
    _hasCrashed = true;
    _gameOver.setVisible(true);
    Flame.audio.play(Sound.crash);
//    _bird.die();
    Flame.bgm.stop();
    gameState = GameState.finished;
  }
}
