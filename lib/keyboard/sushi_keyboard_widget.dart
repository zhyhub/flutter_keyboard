import 'package:flutter/material.dart';
import 'package:flutter_keyboard/keyboard/sushi_keyboard_button.widget.dart';

class KeyEvent {
  String key;

  KeyEvent(this.key);

  bool delete() => this.key == 'delete';

  bool commit() => this.key == 'commit';
}

enum KeyboardType {
  area,
  number,
}

const List<String> areaList = [
  '京',
  '津',
  '冀',
  '鲁',
  '晋',
  '蒙',
  '辽',
  '吉',
  '黑',
  '沪',
  '苏',
  '浙',
  '皖',
  '闽',
  '赣',
  '豫',
  '鄂',
  '湘',
  '粤',
  '桂',
  '渝',
  '川',
  '贵',
  '云',
  '藏',
  '陕',
  '甘',
  '青',
  '琼',
  '新',
  '港',
  '澳',
  '台',
  '宁'
];

const List<String> numberList = [
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  'Q',
  'W',
  'E',
  'R',
  'T',
  'Y',
  'U',
  'I',
  'O',
  'P',
  'A',
  'S',
  'D',
  'F',
  'G',
  'H',
  'J',
  'K',
  'L',
  'Z',
  'X',
  'C',
  'V',
  'B',
  'N',
  'M',
  'delete'
];

/// 自定义车牌号 键盘
class SushiKeyboardWidget extends StatefulWidget {
  final keyCallback;
  final List<String> data;

  SushiKeyboardWidget({this.keyCallback, @required this.data});

  @override
  _SushiKeyboardWidgetState createState() => _SushiKeyboardWidgetState();
}

class _SushiKeyboardWidgetState extends State<SushiKeyboardWidget> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  KeyboardType _keyboardType = KeyboardType.area;

  List<String> _list = List();

  @override
  void initState() {
    super.initState();
    _list = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _globalKey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 9 * 5 + 20,
      padding: const EdgeInsets.only(bottom: 5),
      color: Color(0xFFB3B3B3),
      child: Column(
        children: <Widget>[
          Container(
            height: 30.0,
            color: Colors.white,
            alignment: Alignment.center,
            child: new Text(
              '下滑隐藏',
              style: new TextStyle(fontSize: 12.0, color: Color(0xff999999)),
            ),
          ),
          (_keyboardType == KeyboardType.area && _list.isEmpty)
              ? _buildKeyboardWidget(areaList)
              : _buildKeyboardWidget(numberList),
        ],
      ),
    );
  }

  _onClick(String text) {
    widget.keyCallback(KeyEvent(text));

    if (_list.isEmpty && text.contains('delete')) {
      setState(() {
        _keyboardType = KeyboardType.area;
      });
    } else {
      setState(() {
        _keyboardType = KeyboardType.number;
      });
    }
  }

  Widget _buildKeyboardWidget(List<String> list) {
    List<Widget> _areaWidgets = List();
    list.asMap().forEach((k, v) {
      return _areaWidgets.add(
        SushiKeyboardButton(
          text: v,
          callback: (val) => _onClick(val),
        ),
      );
    });
    return Wrap(
      children: _areaWidgets,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      spacing: 5.0,
    );
  }
}
