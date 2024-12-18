import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/calculator': (context) => CalculatorScreen(),
        '/exit': (context) => ExitScreen(),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/calculator');
          },
          child: Text('Open Calculator'),
        ),
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '';
  String _currentValue = '';
  String _operator = '';
  double _result = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState();

  void _onDigitPress(String digit) {
    setState(() {
      _currentValue += digit;
    });
  }

  void _onOperatorPress(String operator) {
    setState(() {
      if (_currentValue.isNotEmpty) {
        _operator = operator;
        _result = double.parse(_currentValue);
        _currentValue = '';
      }
    });
  }

  void _onEqualsPress() {
    setState(() {
      if (_currentValue.isNotEmpty && _operator.isNotEmpty) {
        final double currentValue = double.parse(_currentValue);

        switch (_operator) {
          case '+':
            _result += currentValue;
            break;
          case '-':
            _result -= currentValue;
            break;
          case '*':
            _result *= currentValue;
            break;
          case '/':
            if (currentValue != 0) {
              _result /= currentValue;
            } else {
              _display = "Error";
              return;
            }
            break;
        }
        _display = _result.toString();
        _currentValue = '';
        _operator = '';
      }
    });
  }

  void _onClear() {
    setState(() {
      _display = '';
      _currentValue = '';
      _operator = '';
      _result = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Add a key for the scaffold
      appBar: AppBar(
        title: Text('Flutter Calculator'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Exit'),
              onTap: () {
                Navigator.pushNamed(context, '/exit');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(16),
            child: Text(
              _display.isNotEmpty ? _display : '$_result',
              style: TextStyle(fontSize: 36),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton('7'),
              buildButton('8'),
              buildButton('9'),
              buildButton('+'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton('4'),
              buildButton('5'),
              buildButton('6'),
              buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton('1'),
              buildButton('2'),
              buildButton('3'),
              buildButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton('0'),
              buildButton('C'),
              buildButton('='),
              buildButton('/'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(String text) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (text == 'C') {
            _onClear();
          } else if (text == '=') {
            _onEqualsPress();
          } else if (['+', '-', '*', '/'].contains(text)) {
            _onOperatorPress(text);
          } else {
            _onDigitPress(text);
          }
        },
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class ExitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exit'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).popUntil(ModalRoute.withName('/'));
          },
          child: Text('Exit App'),
        ),
      ),
    );
  }
}
