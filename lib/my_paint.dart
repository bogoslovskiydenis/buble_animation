import 'dart:math';

import 'package:buble_animation/model/particle.dart';
import 'package:buble_animation/my_painter_canvas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPaint extends StatefulWidget {
  const MyPaint({Key? key}) : super(key: key);

  @override
  _MyPaintState createState() => _MyPaintState();
}

double maxRadius = 6;
double maxSpeed = 1;
double maxTheta = 2.0 * pi;

class _MyPaintState extends State<MyPaint> with SingleTickerProviderStateMixin {
  late List<Particle> particles;
  late Animation<double> animation;
  late AnimationController controller;

  Random rnd = Random(DateTime.now().microsecondsSinceEpoch);

  // Color getRandColor() {
  //   Random rnd = Random();
  //   var a = rnd.nextInt(256);
  //   var r = rnd.nextInt(256);
  //   var g = rnd.nextInt(256);
  //   var b = rnd.nextInt(256);
  //   return Color.fromARGB(a, r, g, b);
  // }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();

    particles = List.generate(1000, (index) {
      var p = Particle();
      p.color = Colors.amber;
      p.position = const Offset(-1, -1);
      p.speed = rnd.nextDouble() * maxSpeed;
      p.theta = rnd.nextDouble() * maxTheta;
      p.radius = rnd.nextDouble() * maxRadius;
      return p;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation Buble"),
      ),
      body: CustomPaint(
        child: Container(),
        painter: MyPaintCanvas(particles, rnd, animation.value),
      ),
    );
  }
}
