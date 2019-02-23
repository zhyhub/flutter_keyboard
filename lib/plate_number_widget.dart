import 'package:flutter/material.dart';

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
//  '删'
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
  '删'
];

final List<Widget> areaTextList = <Widget>[];
final List<Widget> numberTextList = <Widget>[];

class PlateNumberKeyboard extends StatefulWidget {
  PlateNumberKeyboard({
    Key key,
    @required this.results,
    this.onResultController,
  }) : super(key: key);

  final List<String> results;

  final onResultController;

  @override
  _PlateNumberKeyboardState createState() => _PlateNumberKeyboardState();

  static void showKeyboard(BuildContext context, List<String> resultList,
      onResultController(List<String> results)) {
    showBottomSheet(
        context: context,
        builder: (_) {
          return PlateNumberKeyboard(
            results: resultList,
            onResultController: onResultController,
          );
        });
  }
}

class _PlateNumberKeyboardState extends State<PlateNumberKeyboard>
    with SingleTickerProviderStateMixin {
  double _baseWidth;
  double _baseHeight;
  double _deleteWidth;
  double _deleteHeight;

  List<String> _results;
  KeyboardType _keyboardType;

  void addResult() {
    if (_results.length < 8) {
      widget.onResultController(_results);
    }
  }

  @override
  void initState() {
    super.initState();
    areaTextList.clear();
    numberTextList.clear();
    _results = widget.results;
    _keyboardType = KeyboardType.area;
  }

  @override
  void dispose() {
    super.dispose();
    areaTextList.clear();
    numberTextList.clear();
  }

  _getAreaKeyboard() {
    areaList.asMap().forEach((k, v) {
      return areaTextList.add(
        buildAreaContainer(v),
      );
    });
  }

  _getNumberKeyboard() {
    numberList.asMap().forEach((k, v) {
      return numberTextList.add(
        k == numberList.length - 1
            ? buildNumberDeleteContainer()
            : buildNumberContainer(v),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _baseWidth = MediaQuery.of(context).size.width / 12;
    _baseHeight = MediaQuery.of(context).size.width / 9;

    _deleteWidth = MediaQuery.of(context).size.width / 6;
    _deleteHeight = MediaQuery.of(context).size.width / 9;

    _keyboardType == KeyboardType.area
        ? _getAreaKeyboard()
        : _getNumberKeyboard();

    return Container(
      width: _baseWidth * 12,
      padding: const EdgeInsets.only(bottom: 5),
      color: Color(0xFFB3B3B3),
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        children:
            _keyboardType == KeyboardType.area ? areaTextList : numberTextList,
        spacing: 5.0,
      ),
    );
  }

  Widget buildAreaContainer(String v) {
    return Container(
      width: _baseWidth,
      height: _baseHeight,
      margin: const EdgeInsets.only(top: 5),
      child: RaisedButton(
        padding: const EdgeInsets.all(5),
        child: Text(
          v,
          style: TextStyle(fontSize: 20.0),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        onPressed: () {
          _results.add(v);
          addResult();
          setState(() {
            numberTextList.clear();
            _keyboardType = KeyboardType.number;
          });
        },
        color: Colors.white,
      ),
    );
  }

  Widget buildNumberDeleteContainer() {
    return Container(
      width: _deleteWidth,
      height: _deleteHeight,
      margin: const EdgeInsets.only(top: 5),
      child: RaisedButton(
        padding: const EdgeInsets.all(5),
        child: Icon(Icons.delete_forever),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        onPressed: () {
          _results.remove(_results.last);
          if (_results.length == 0) {
            setState(() {
              areaTextList.clear();
              _keyboardType = KeyboardType.area;
            });
            _results.clear();
          }
          addResult();
        },
        color: Colors.white,
      ),
    );
  }

  Widget buildNumberContainer(String v) {
    return Container(
      width: _baseWidth,
      height: _baseHeight,
      margin: const EdgeInsets.only(top: 5),
      child: (v.contains('I') || v.contains('O')
          ? RaisedButton(
              padding: const EdgeInsets.all(5),
              child: Text(
                v,
                style: TextStyle(fontSize: 20.0),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
            )
          : RaisedButton(
              padding: const EdgeInsets.all(5),
              child: Text(
                v,
                style: TextStyle(fontSize: 20.0),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              onPressed: () {
                if (_results.length < 7) {
                  _results.add(v);
                }
                addResult();
              },
              color: Colors.white,
            )),
    );
  }
}
