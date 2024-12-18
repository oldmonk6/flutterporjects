import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/calculator': (context) => const CalculatorScreen(),
        '/exit': (context) => const ExitScreen(),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/calculator');
          },
          child: const Text('Open Calculator'),
        ),
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '';
  String _currentValue = '';
  String _operator = '';
  double _result = 0;

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

  void _onTrigOperation(String operation) {
    setState(() {
      if (_currentValue.isNotEmpty && !'+-*/'.contains(_currentValue[_currentValue.length - 1])) {
        double value = double.parse(_currentValue);
        if (operation == 'sin') {
          _currentValue = sin(value).toString();
        } else if (operation == 'cos') {
          _currentValue = cos(value).toString();
        } else if (operation == 'tan') {
          _currentValue = tan(value).toString();
        }
      }
    });
  }

  void _onBracketOperation(String bracket) {
    setState(() {
      if (bracket == '(') {
        _currentValue += bracket;
      } else if (bracket == ')' && _currentValue.contains('(') && !_currentValue.endsWith('(')) {
        _currentValue += bracket;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Calculator'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Exit'),
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
            padding: const EdgeInsets.all(16),
            child: Text(
              _display.isNotEmpty ? _display : '$_result',
              style: const TextStyle(fontSize: 36),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton('sin'),
              buildButton('cos'),
              buildButton('tan'),
              buildButton('('),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton(')'),
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
          } else if ('+-*/'.contains(text)) {
            _onOperatorPress(text);
          } else if (['sin', 'cos', 'tan'].contains(text)) {
            _onTrigOperation(text);
          } else if (text == '(' || text == ')') {
            _onBracketOperation(text);
          } else {
            _onDigitPress(text);
          }
        },
        child: Container(
          height: 80,
          decoration:  BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class ExitScreen extends StatelessWidget {
  const ExitScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exit'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).popUntil(ModalRoute.withName('/'));
          },
          child: const Text('Exit App'),
        ),
      ),
    );
  }
}
