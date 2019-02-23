import 'package:flutter/material.dart';
import 'package:flutter_keyboard/plate_number_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Test(),
    );
  }
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  List<String> resultList = List();
  String str;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '测试',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 1.0,
        backgroundColor: Color(0xFF1F1F25),
      ),
      body: Builder(builder: (BuildContext context) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(resultList.toString()),
              Container(
                height: 50,
              ),
              InkWell(
                child: Text("点我！！！！！！"),
                onTap: () {
                  showBottomSheet(
                      context: context,
                      builder: (_) {
                        return PlateNumberKeyboard(
                          backResult: (val) => onDataChange(val),
                          results: resultList,
                        );
                      });
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  onDataChange(List<String> results) {
    setState(() {
      resultList = results;
      print('onDataChange =======  $resultList');
    });
  }
}
