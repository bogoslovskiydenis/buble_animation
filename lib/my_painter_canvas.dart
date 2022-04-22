import 'dart:math';

import 'package:buble_animation/model/particle.dart';
import 'package:flutter/material.dart';

class MyPaintCanvas extends CustomPainter {
  List<Particle> particles;
  Random rnd;

  MyPaintCanvas(this.particles, this.rnd);

  @override
  void paint(Canvas canvas, Size size) {
    //update
    for (var p in particles) {
      var velocity = polarToDecart(p.speed!, p.theta!);
      var dx = p.position.dx + velocity.dx;
      var dy = p.position.dy + velocity.dy;
      if (p.position.dx < 0 || p.position.dx > size.width) {
        dx = rnd.nextDouble() * size.width;
      }
      if (p.position.dy < 0 || p.position.dx > size.height) {
        dx = rnd.nextDouble() * size.height;
      }
      p.position = Offset(dx, dy);
    }

    //paint object
    this.particles.forEach((p) {
      var paint = Paint();
      paint.color = Colors.red;
      canvas.drawCircle(p.position, p.radius!, paint);
    });
    //big buble
    // var dx = size.width / 2;
    // var dy = size.width / 2;
    // var c = Offset(dx, dy);
    // var radius = 50.0;
    // var paint = Paint();
    // paint.color = Colors.red;
    // canvas.drawCircle(c, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter o) {
    return true;
  }
}

Offset polarToDecart(double speed, double theta) {
  return Offset(speed * cos(theta), speed * sin(theta));
}
