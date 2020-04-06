import 'package:flutter/material.dart';

class LogoPainter extends CustomPainter {
  static Color backgroundColorGradient;
  LogoPainter({Color backgroundColor}) {
    backgroundColorGradient = backgroundColor;
  }

  final Path quadPath = new Path()
    ..moveTo(-5, 0)
    ..lineTo(35, 0)
    ..lineTo(200, 300)
    ..lineTo(-100, 200);

  final Gradient gradient = new LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Colors.white38, backgroundColorGradient],
    stops: [0.1, 0.51],
  );
  Rect rect = new Rect.fromCircle(
    center: new Offset(165.0, 55.0),
    radius: 180.0,
  );
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()..shader = gradient.createShader(rect);
    canvas.drawPath(quadPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
