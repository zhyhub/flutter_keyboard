import 'package:flutter/material.dart';
import 'package:flutter_keyboard/keyboard/sushi_input_widget.dart';
import 'package:flutter_keyboard/keyboard/sushi_keyboard_widget.dart';

class SushiPlatesWidget extends StatefulWidget {
  @override
  _SushiPlatesWidgetState createState() => _SushiPlatesWidgetState();
}

class _SushiPlatesWidgetState extends State<SushiPlatesWidget> {
  String _text = '';

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  VoidCallback _showBottomSheetCallback;

  List<String> _results = List();

  void _showBottomSheet() {
    setState(() {
      _showBottomSheetCallback = null;
    });

    _globalKey.currentState
        .showBottomSheet<void>((BuildContext context) {
          return SushiKeyboardWidget(
            keyCallback: _onKeyDown,
            data: _results,
          );
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showBottomSheetCallback = _showBottomSheet;
            });
          }
        });
  }

  void _onKeyDown(KeyEvent data) {
    if (data.delete()) {
      if (_text.length > 0) {
        _text = _text.substring(0, _text.length - 1);
        _results.remove(_results.last);
        setState(() {});
      }
    } else if (data.commit()) {
      if (_text.length != 7) {
        return;
      }
      onAffirmButton();
    } else {
      if (_text.length < 7) {
        _text += data.key;
        _results.add(data.key);
      }
      setState(() {});
    }
    setState(() {});
  }

  void onAffirmButton() {}

  @override
  void initState() {
    _showBottomSheetCallback = _showBottomSheet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _globalKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '测试',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 1.0,
        backgroundColor: Color(0xFF1F1F25),
      ),
      body: _buildText(_results),
    );
  }

  Widget _buildText(List<String> list) {
    return GestureDetector(
      child: Container(
        child: SushiInputWidget(_text),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      ),
      onTap: () {
        if (_showBottomSheetCallback != null) {
          _showBottomSheetCallback();
        }
      },
    );
  }
}
