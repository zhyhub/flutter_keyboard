import 'package:flutter/material.dart';
import 'package:flutter_keyboard/keyboard/sushi_plates_widget.dart';

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
      body: Center(
        child: FlatButton(
          color: Colors.greenAccent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SushiPlatesWidget()),
            );
          },
          child: Text('车牌键盘'),
        ),
      ),
    );
  }
}
