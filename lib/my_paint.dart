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
double maxSpeed = 16;
double maxTheta = 2.0 * pi;

class _MyPaintState extends State<MyPaint> with SingleTickerProviderStateMixin {
  late List<Particle> particles;
  late Animation<double> animation;
  late AnimationController controller;

  Random rnd = Random(DateTime.now().microsecondsSinceEpoch);

  Color getRandColor(Random rnd) {
    var a = rnd.nextInt(500);
    var r = rnd.nextInt(500);
    var g = rnd.nextInt(500);
    var b = rnd.nextInt(500);
    return Color.fromARGB(a, r, g, b);
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)..addListener(() {
      setState(() {
        // The state that has changed here is the animation object’s value.
      });
    });
       controller.forward();

    particles = List.generate(1, (index) {
      var p = Particle();
      p.color = getRandColor(rnd);
      p.position = const Offset(-1, 1);
      p.speed = rnd.nextDouble() * maxSpeed;
      p.theta = rnd.nextDouble() * maxTheta;
      p.radius = rnd.nextDouble() * maxRadius;
      return p;
    });
  }

        @override
        void dispose() {
controller.dispose();
    }

    var size, height, width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation Buble"),
      ),
      body: CustomPaint(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        painter: MyPaintCanvas(particles, rnd),
      ),
    );
  }
}

