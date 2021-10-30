import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 2), lowerBound: 0.2)
      ..forward();

    _animationController.addListener(
      () async {
        if (_animationController.status == AnimationStatus.completed) {
          await Future.delayed(const Duration(milliseconds: 600));
          _animationController.reverse();
        } else if (_animationController.value == .2) {
          await Future.delayed(const Duration(milliseconds: 600));
          _animationController.forward();
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: _animationController.value * pi,
                    child: CustomPaint(
                      painter: Flower(colorO: Colors.white),
                      size: Size(_animationController.value * 100,
                          _animationController.value * 100),
                    ),
                  ),
                  Transform.rotate(
                    angle: _animationController.value * pi,
                    child: CustomPaint(
                      painter:
                          Flower(color1: Colors.purple, color2: Colors.pink),
                      size: Size(_animationController.value * 100,
                          _animationController.value * 100),
                    ),
                  ),
                  Transform.rotate(
                    angle: _animationController.value * pi,
                    child: CustomPaint(
                      painter: Flower(
                          isRadial: true,
                          color1: Colors.purple,
                          color2: Colors.pink),
                      size: Size(_animationController.value * 100,
                          _animationController.value * 100),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class Flower extends CustomPainter {
  final Color? colorO;
  final Color? color1;
  final Color? color2;
  final bool isRadial;
  Flower({this.colorO, this.color1, this.color2, this.isRadial = false});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.height / 2;

    final _paint = Paint()
      ..style = colorO != null ? PaintingStyle.stroke : PaintingStyle.fill
      ..color = Colors.white
      ..strokeWidth = 1
      ..shader = color1 != null
          ? isRadial
              ? ui.Gradient.linear(const Offset(0, 50), const Offset(50, 100),
                  [color1!.withOpacity(0.5), color2!.withOpacity(0.5)])
              : ui.Gradient.radial(
                  Offset(size.height / 2, size.width / 2),
                  size.width / 2,
                  [color1!.withOpacity(0.5), color2!.withOpacity(0.5)])
          : null;
    // canvas.drawCircle(
    //     Offset(size.height / 2, size.width / 2), size.width / 2, _paint);

    for (var i = 0; i < 6; i++) {
      final xPoint = center + cos(degreeToRadian(60.0 * i)) * center;
      final yPoint = center + sin(degreeToRadian(60.0 * i)) * center;
      canvas.drawCircle(Offset(xPoint, yPoint), size.width / 2, _paint);
    }
  }

  double degreeToRadian(double degree) {
    return degree * (pi / 180);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
