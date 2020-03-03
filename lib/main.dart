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
  GameController game = GameController();
  runApp(game.widget);
  Flame.bgm.initialize();
  Flame.audio.disableLog();
}
