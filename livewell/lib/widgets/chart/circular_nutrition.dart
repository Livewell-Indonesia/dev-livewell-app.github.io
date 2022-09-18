import 'package:flutter/material.dart';
import 'dart:math' as math;

class MultipleColorCircle extends StatelessWidget {
  final Map<Color, int> colorOccurrences;
  final double height;
  final Widget? child;
  @override
  MultipleColorCircle(
      {required this.colorOccurrences, this.height = 20, this.child});
  Widget build(BuildContext context) => Container(
        height: height,
        width: height,
        child: CustomPaint(
            size: Size(height, height),
            child: Center(child: child),
            painter: _MultipleColorCirclePainter(
              colorOccurrences: colorOccurrences,
              height: height,
            )),
      );
}

class _MultipleColorCirclePainter extends CustomPainter {
  final Map<Color, int> colorOccurrences;
  final double height;
  @override
  _MultipleColorCirclePainter(
      {required this.colorOccurrences, required this.height});
  double pi = math.pi;

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 20;
    Rect myRect = Rect.fromCircle(
        center: Offset(height / 2, height / 2), radius: height / 2);

    double radianStart = 0;
    double radianLength = 0;
    int allOccurrences = 0;
    canvas.drawColor(Colors.white, BlendMode.color);
    //set denominator
    colorOccurrences.forEach((color, occurrence) {
      allOccurrences += occurrence;
    });
    colorOccurrences.forEach((color, occurrence) {
      double percent = occurrence / allOccurrences;
      radianLength = 2 * percent * math.pi;
      canvas.drawArc(
          myRect,
          radianStart,
          radianLength,
          false,
          Paint()
            ..color = color
            ..strokeWidth = strokeWidth
            ..style = PaintingStyle.stroke);
      radianStart += radianLength;
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
