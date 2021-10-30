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

class CreditReport extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    // canvas.drawCircle(center, size.width / 2, Paint());

//     X := originX + cos(angle)*radius;
// Y := originY + sin(angle)*radius;
    final angle = 770 * (190);
    final ang = angle / 850;

    final raduis = size.width / 2;
    final x = center.dx + cos(ang) * raduis;
    final y = center.dy + sin(ang) * raduis;
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: raduis),
        pi,
        pi / 3,
        false,
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15
          ..strokeCap = StrokeCap.round);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: raduis),
        pi * 1.38,
        pi / 7,
        false,
        Paint()
          ..color = Colors.yellow
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15
          ..strokeCap = StrokeCap.round);
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: raduis),
        pi * 1.58,
        pi / 7,
        false,
        Paint()
          ..color = Colors.yellow
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15
          ..strokeCap = StrokeCap.round);
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: raduis),
        pi * 1.78,
        pi / 4.5,
        false,
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15
          ..strokeCap = StrokeCap.round);
    canvas.drawCircle(Offset(y, x), 12, Paint()..color = Colors.white);
    canvas.drawCircle(
        Offset(y, x),
        7,
        Paint()
          ..color = Colors.black
          ..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Clock extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final backGroundCirclePaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.square
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    final middleCirclePaint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.square
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;
    canvas.drawLine(
        Offset(size.width / 2, 100), center, middleCirclePaint); //minutehand
    canvas.drawLine(Offset((size.width / 2) + 50, 60), center,
        backGroundCirclePaint); //hourhand
    // canvas.drawRect(
    //     Rect.fromCenter(center: center, width: size.width, height: size.height),
    //     backGroundCirclePaint);
    canvas.drawCircle(center, 10, middleCirclePaint);

    canvas.drawCircle(
        center, size.height / 2, backGroundCirclePaint..strokeWidth = 5);
    canvas.drawLine(Offset(size.width, size.height / 2),
        Offset(size.width - 20, size.height / 2), middleCirclePaint);
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, 20),
        middleCirclePaint);
    canvas.drawLine(Offset(size.width / 2, size.height),
        Offset(size.width / 2, size.height - 20), middleCirclePaint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(20, size.height / 2),
        middleCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
