import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: "Calc"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String exp = "0";
  String finOut = "0";

  buttonPressed(String opcode) {
    String _exp = exp;
    String _finOut = finOut;

    if (opcode == "C") {
      _exp = "0";
      _finOut = "0";
    } else if (opcode == "←") {
      _exp = _exp.substring(0, _exp.length - 1);
      if (_exp == "") _exp = "0";
    } else if (opcode == ".") {
      String last = _exp.substring(_exp.length - 1);
      if (last != ".") {
        if (last == "+" || last == "-" || last == "*" || last == "/")
          _exp += "0";
        _exp += opcode;
      }
    } else if (opcode == "+" ||
        opcode == "-" ||
        opcode == "*" ||
        opcode == "/") {
      String last = _exp.substring(_exp.length - 1);
      if (last != "+" && last != "-" && last != "*" && last != "/") {
        if (last == ".") _exp += "0";
        _exp += opcode;
      }
    } else if (opcode == "=") {
      try {
        _finOut = _exp.interpret().toStringAsFixed(6);
      } catch (e) {
        finOut = "Invalid Input";
      }
    } else {
      if (_exp == "0") _exp = "";
      _exp += opcode;
    }

    setState(() {
      exp = _exp;
      finOut = _finOut;
    });
  }

  Widget buildButton(String buttonText) {
    return new Expanded(
      child: new OutlineButton(
        child: new Text(
          buttonText,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        padding: new EdgeInsets.all(22.0),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Expanded(child: Divider()),
            new Container(
              alignment: Alignment.centerRight,
              padding:
                  new EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: new Text(exp,
                  style: new TextStyle(
                      fontSize: 48.0, fontWeight: FontWeight.bold)),
            ),
            new Container(
              alignment: Alignment.centerRight,
              padding:
                  new EdgeInsets.symmetric(vertical: 18.0, horizontal: 9.0),
              child: new Text(
                finOut,
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w500),
              ),
            ),
            new Expanded(child: Divider()),
            new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("+"),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("-"),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("*"),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    buildButton("."),
                    buildButton("0"),
                    buildButton("00"),
                    buildButton("/"),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    buildButton("C"),
                    buildButton("←"),
                    buildButton("=")
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
