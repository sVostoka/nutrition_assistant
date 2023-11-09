import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BottomAppBarPainter extends CustomPainter {
  const BottomAppBarPainter({
    required this.color,
    required this.geometry,
    required this.shape,
    required this.notchMargin,
  });

  final ValueListenable<ScaffoldGeometry> geometry;
  final NotchedShape shape;
  final double notchMargin;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect? button = geometry.value.floatingActionButtonArea?.translate(
      0.0,
      geometry.value.bottomNavigationBarTop! * -1.0,
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = color;

    final path = shape.getOuterPath(Offset.zero & size, button?.inflate(notchMargin));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}