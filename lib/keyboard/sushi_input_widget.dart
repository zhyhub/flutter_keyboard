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
    print('paint ======== ${size.width}');
    _rectPaint = Paint()
      ..color = Color(0xff707070)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..isAntiAlias = true;

    double _width = (size.width - ((pinLength - 1) * 16)) / pinLength;

    double startX = 0.0;
    double startY = _width + 10;

    for (int i = 0; i < pinLength; i++) {
      RRect rRect = RRect.fromRectAndRadius(
          Rect.fromLTRB(
            startX,
            0,
            startX + startY,
            startY,
          ),
          Radius.circular(0.0));
      canvas.drawRRect(rRect, _rectPaint);
      if (i == pinLength - 1) {
        startX = size.width;
      } else {
        startX += _width + 16;
      }
      print('fromRectAndRadius ======== $startX  ,  $startY  , $_width');
    }

    var index = 0;
    startY = 0.0;

    text.runes.forEach((rune) {
      String code = String.fromCharCode(rune);
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
          ),
          text: code,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      if (startY == 0.0) {
        startY = _width / 2 - textPainter.height / 2 + 6;
      }
      startX = _width * index +
          _width / 2 -
          textPainter.width / 2 +
          16 * index +
          index * 2;

      textPainter.paint(canvas, Offset(startX, startY));
      index++;

      print(
          'TextPainter ======== $startX  ,  $startY , $index  ， =======   ${textPainter.height}   ....   ${textPainter.width}');
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
