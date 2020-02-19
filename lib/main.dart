import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  FlappyBirdGame game = FlappyBirdGame();
  runApp(game.widget);
  // should move to somewhere else?
  Flame.bgm.initialize();
  Flame.bgm.play('bgm.mp3');
}