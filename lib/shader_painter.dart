import 'dart:ui';

import 'package:flutter/material.dart';

class ShaderPainter extends CustomPainter {
  const ShaderPainter({
    required this.shader,
    required this.points,
  });

  final FragmentShader shader;
  final List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);

    for (var i = 0; i < points.length; i++) {
      shader.setFloat(2 + i * 2, points[i].dx); // -1.0 ~ 1.0
      shader.setFloat(3 + i * 2, points[i].dy); // -1.0 ~ 1.0
    }
    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
