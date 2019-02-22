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

// ignore: must_be_immutable
class PlateNumberKeyboard extends StatefulWidget {
  PlateNumberKeyboard({
    Key key,
    this.keyboardType = KeyboardType.area,
    this.callback,
  }) : super(key: key);

  KeyboardType keyboardType;

  final callback;

  @override
  _PlateNumberKeyboardState createState() => _PlateNumberKeyboardState();
}

class _PlateNumberKeyboardState extends State<PlateNumberKeyboard>
    with SingleTickerProviderStateMixin {
  List<String> results = List();

  void addResult() {
    print('addResult   $results');
    if (results.length < 8) {
      widget.callback(results);
    }
  }

  @override
  void initState() {
    super.initState();
    areaTextList.clear();
    numberTextList.clear();
  }

  @override
  void didUpdateWidget(PlateNumberKeyboard oldWidget) {
    super.didUpdateWidget(oldWidget);
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
//        k == areaList.length - 1
//            ? Container(
//                width: MediaQuery.of(context).size.width / 6,
//                height: MediaQuery.of(context).size.width / 9,
//                margin: const EdgeInsets.only(top: 5),
//                child: RaisedButton(
//                  padding: const EdgeInsets.all(5),
//                  child: Icon(Icons.delete_forever),
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
//                  ),
//                  onPressed: () {
//                    print('_PlateNumberKeyboardState $v ');
//                    results.clear();
//                    addResult();
//                  },
//                  color: ColorT.backgroundColor,
//                ),
//              )
//            :
        Container(
          width: MediaQuery.of(context).size.width / 12,
          height: MediaQuery.of(context).size.width / 9,
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
              print('_PlateNumberKeyboardState $v ');
              results.add(v);
              addResult();
              setState(() {
                numberTextList.clear();
                widget.keyboardType = KeyboardType.number;
              });
            },
            color: Colors.white,
          ),
        ),
      );
    });
  }

  _getNumberKeyboard() {
    numberList.asMap().forEach((k, v) {
      return numberTextList.add(
        k == numberList.length - 1
            ? Container(
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.width / 9,
                margin: const EdgeInsets.only(top: 5),
                child: RaisedButton(
                  padding: const EdgeInsets.all(5),
                  child: Icon(Icons.delete_forever),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  onPressed: () {
                    results.remove(results.last);
                    print('_PlateNumberKeyboardState ${results.toString()} ');
                    if (results.length == 0) {
                      setState(() {
                        areaTextList.clear();
                        widget.keyboardType = KeyboardType.area;
                      });
                      results.clear();
                    }
                    addResult();
                  },
                  color: Colors.white,
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width / 12,
                height: MediaQuery.of(context).size.width / 9,
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
                          print('_PlateNumberKeyboardState $v ');
                          if (results.length < 7) {
                            results.add(v);
                          }
                          addResult();
                        },
                        color: Colors.white,
                      )),
              ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.keyboardType == KeyboardType.area
        ? _getAreaKeyboard()
        : _getNumberKeyboard();

    return widget.keyboardType == KeyboardType.area
        ? Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(bottom: 5),
            color: Color(0xFFB3B3B3),
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: areaTextList,
              spacing: 5.0,
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(bottom: 5),
            color: Color(0xFFB3B3B3),
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: numberTextList,
              spacing: 5.0,
            ),
          );
  }
}
