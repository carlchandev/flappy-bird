import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flame/animation.dart' as fa;
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/box2d/viewport.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flappy_bird/config/sound.dart';
import 'package:flutter/gestures.dart';

class Bird extends BodyComponent {
  BirdComponent b;
  Viewport v;
  double width = 51;
  double height = 36;

  Bird(Box2DComponent box) : super(box) {
    b = BirdComponent(width, height);
    v = box.viewport;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position = Vector2.zero();

    body = world.createBody(bd);

    CircleShape shape = CircleShape();
    shape.radius = 25;

    FixtureDef fd = FixtureDef();
    fd.shape = shape;
    fd.density = 1;
    fd.friction = 0;
    fd.restitution = 1;

    body.createFixtureFromFixtureDef(fd);
    print("Bird created");

    b.debugMode = true;
  }

  void onTapDown(TapDownDetails details) {
    Vector2 velocity = body.getLinearVelocityFromLocalPoint(body.getLocalCenter());
    print("before jump v: $velocity");
    velocity.y += 10000;
    body.linearVelocity = velocity;
  }

  @override
  void resize(Size size) {
    super.resize(size);
    updatePosition();
    b.resize(size);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    b.render(canvas);
  }

  @override
  void update(double t) {
    super.update(t);
    updatePosition();
    b.update(t);
  }

  void updatePosition() {
    if (b.y > 700) {
      body.setTransform(Vector2(0, viewport.height), 0);
    }
    Vector2 p = v.getWorldToScreen(body.position);
    b.x = p.x - width / 2;
    b.y = p.y - height / 2;
//    print('bird pixel (${b.x}, ${b.y})');
  }

  void remove() => b.remove();
}

class BirdComponent extends AnimationComponent {
  static final List<Sprite> sprites =
      [0, 1, 2, 1].map((i) => Sprite('bird$i.png')).toList();

  double velocity = -2.3;
  double gravityAcceleration = 0.35;
  double timeCount = 0;
  double displacement;
  bool isDead = false;
  bool isDestroy = false;

  BirdComponent(width, height)
      : super(width, height, fa.Animation.spriteList(sprites, stepTime: 0.08));

//  @override
//  void update(double t) {
//    if (_game.gameState == GameState.playing || isDead) {
//      _move();
//    }
//    if (!isDead) {
//      super.update(t);
//    }
//  }

//  void _move() {
//    if (isDead) {
//      timeCount = timeCount < 10 ? 10 : timeCount;
//    }
//    displacement = (velocity * timeCount) +
//        (0.5 * gravityAcceleration * pow(timeCount, 2));
//    if (timeCount < 19) {
//      timeCount += 0.6;
//    }
//    if (y < _game.height - height) {
//      if (isDead) {
//        angle += pi / 3;
//      }
//      y += displacement;
//    }
//  }

//  void jump() {
//    if (!isDead) {
//      Flame.audio.play(Sound.jump, volume: 0.5);
//      timeCount = 0;
//    }
//  }

  void die() {
    Flame.audio.play(Sound.die);
    isDead = true;
  }

  @override
  bool destroy() => isDestroy;

  void remove() => isDestroy = true;
}
