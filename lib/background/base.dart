import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/box2d/viewport.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

class Base extends BodyComponent {
  BaseComponent b;
  Viewport v;
  double baseWidth;

  double baseHeight = 100;

  Base(Box2DComponent box) : super(box) {
    b = BaseComponent();
    v = box.viewport;
    baseWidth = viewport.width;

    final BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position = Vector2(0, -(viewport.height / 2) + baseHeight / 2);

    body = world.createBody(bd);

    print('constructor viewport width: ${viewport.width}');
    print('constructor viewport height: ${viewport.height}');
    final PolygonShape shape = PolygonShape();
    shape.setAsBoxXY(viewport.width / 2, 50);

    final FixtureDef fd = FixtureDef();
    fd.shape = shape;
    fd.density = 1;
    fd.friction = 1;
    fd.restitution = 1;

    body.createFixtureFromFixtureDef(fd);
    print("Base created");

    b.debugMode = true;
  }

  @override
  void resize(Size size) {
    super.resize(size);
    print('resize viewport width: ${viewport.width}');
    print('resize viewport height: ${viewport.height}');
    updatePosition();
    b.resize(size);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    updatePosition();
    b.render(canvas);
  }

  @override
  void update(double t) {
    super.update(t);
    b.update(t);
  }

  void updatePosition() {
    Vector2 p = v.getWorldToScreen(body.position);
    b.x = p.x - (baseWidth / 2);
    b.y = p.y - (baseHeight / 2);
  }
}

class BaseComponent extends SpriteComponent {
  BaseComponent() : super.fromSprite(500, 100, Sprite('base.png'));
}
