import 'package:flutter/material.dart';

class SushiInputWidget extends StatelessWidget {
  final String text;

  SushiInputWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SushiPainter(text),
    );
  }
}

class _SushiPainter extends CustomPainter {
  String text;

  _SushiPainter(this.text);

  Paint _rectPaint;

  int pinLength = 7;

  double _textSize = 24.0;

  @override
  void paint(Canvas canvas, Size size) {
    _rectPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..isAntiAlias = true;

    double _baseWidth = size.width / pinLength;

    double _x = _baseWidth / 2;
    double _y = _baseWidth / 2;

    for (int i = 0; i < pinLength; i++) {
      Rect rect = Rect.fromCircle(center: Offset(_x, _y), radius: _y);
      RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(0.0));
      canvas.drawRRect(rRect, _rectPaint);
      _x = _x + _baseWidth;
    }

    _x = _baseWidth / 2;

    text.runes.forEach((rune) {
      String code = String.fromCharCode(rune);
      TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: code,
            style: TextStyle(
                color: Colors.white,
                fontSize: _textSize,
                textBaseline: TextBaseline.ideographic,
                fontWeight: FontWeight.normal),
          ),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center);
      textPainter.layout(maxWidth: 0.0, minWidth: 0.0);
      textPainter.paint(canvas,
          Offset(_x - textPainter.width / 2, _y - textPainter.height / 2));

      _x = _x + _baseWidth;
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
