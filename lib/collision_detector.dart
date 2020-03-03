import 'package:flappy_bird/pipe/pipe.dart';
import 'package:flappy_bird/pipe/pipe_bottom.dart';
import 'package:flappy_bird/pipe/pipe_top.dart';

import 'bird/bird.dart';

class CollisionDetector {
  static bool hasBirdCollided(Bird bird, Pipe p) {
    Circle c = Circle(bird.x, bird.y, bird.radius);
    PipeTop t = p.pipeTop;
    Rectangle rectTop = Rectangle(t.x, t.y, t.width, t.height);
    PipeBottom b = p.pipeBottom;
    Rectangle rectBottom = Rectangle(b.x, b.y, b.width, b.height);
    return _hasCollided(c, rectTop) || _hasCollided(c, rectBottom);
  }

  static bool _hasCollided(Circle c, Rectangle r) {
    // Find the vertical & horizontal (distX/distY) distances between the circle’s center and the rectangle’s center
    final distX = (c.x - r.x - r.width / 2).abs();
    final distY = (c.y - r.y - r.height / 2).abs();
    // If the distance is greater than halfCircle + halfRect, then they are too far apart to be colliding
    if (distX > (r.width / 2 + c.radius) || distY > (r.height / 2 + c.radius)) {
      return false;
    }
    // If the distance is less than halfRect then they are definitely colliding
    if (distX <= (r.width / 2) || distY <= (r.height / 2)) {
      return true;
    }
    // Using Pythagoras formula to compare the distance between circle and rect centers.
    final dx = distX - r.width / 2;
    final dy = distY - r.height / 2;
    return (dx * dx + dy * dy <= (c.radius * c.radius));
  }
}

class Circle {
  final double x;
  final double y;
  final double radius;

  const Circle(this.x, this.y, this.radius);
}

class Rectangle {
  final double x;
  final double y;
  final double width;
  final double height;

  Rectangle(this.x, this.y, this.width, this.height);
}
