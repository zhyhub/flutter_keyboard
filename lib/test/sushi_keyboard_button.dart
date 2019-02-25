import 'package:flutter/material.dart';

class SushiKeyboardButton extends StatefulWidget {
  final String text;
  final callback;

  SushiKeyboardButton({Key key, @required this.text, @required this.callback})
      : super(key: key);

  @override
  _SushiKeyboardButtonState createState() => _SushiKeyboardButtonState();
}

class _SushiKeyboardButtonState extends State<SushiKeyboardButton> {
  var backMethod;

  @override
  Widget build(BuildContext context) {
    double _baseWidth = MediaQuery.of(context).size.width / 12;
    double _baseHeight = MediaQuery.of(context).size.width / 9;
    double _deleteWidth = MediaQuery.of(context).size.width / 6;
    return Container(
      height: _baseHeight,
      width: widget.text.contains('delete') ? _deleteWidth : _baseWidth,
      margin: const EdgeInsets.only(top: 5),
      child: RaisedButton(
        padding: const EdgeInsets.all(5),
        child: widget.text.contains('delete')
            ? Icon(Icons.backspace)
            : Text(
                widget.text,
                style: TextStyle(fontSize: 20.0),
              ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        onPressed: (widget.text.contains('I') || widget.text.contains('O'))
            ? null
            : _onPressed,
        color: Colors.white,
      ),
    );
  }

  _onPressed() {
    widget.callback('${widget.text}');
  }
}
