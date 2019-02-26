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

  @override
  void paint(Canvas canvas, Size size) {
    _rectPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..isAntiAlias = true;

    double _x = size.width / 7 / 2;
    double _y = size.width / 7 / 2;
    double _textSize = 18.0;

    for (int i = 0; i < pinLength; i++) {
      Rect rect = Rect.fromCircle(center: Offset(_x, _y), radius: _y);
      RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(0.0));
      canvas.drawRRect(rRect, _rectPaint);
      _x = _x + size.width / 7;
    }

    _x = size.width / 7 / 2;

    text.runes.forEach((rune) {
      String code = String.fromCharCode(rune);
      TextPainter(
          text: TextSpan(
            text: code,
            style: TextStyle(
                color: Colors.white,
                fontSize: _textSize,
                textBaseline: TextBaseline.ideographic,
                fontWeight: FontWeight.bold),
          ),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center)
        ..layout(maxWidth: 0.0, minWidth: 0.0)
        ..paint(canvas, Offset(_x, _y / 2));

      _x = _x + size.width / 7;
      _textSize = 24;
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
