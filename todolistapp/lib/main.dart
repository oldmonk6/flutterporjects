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
      debugShowCheckedModeBanner: false,
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

  bool _showExtendedOperators = false;

  void _updateDisplay() {
    setState(() {
      if (_operator.isNotEmpty) {
        _display = '$_result $_operator $_currentValue';
      } else if (_currentValue.isNotEmpty) {
        _display = _currentValue;
      } else {
        _display = '$_result';
      }
    });
  }


  void _onDigitPress(String digit) {
    setState(() {
      _currentValue += digit;
      _updateDisplay();
    });
  }

  void _onOperatorPress(String operator) {
    setState(() {
      if (_currentValue.isNotEmpty) {
        if (_operator.isEmpty) {
          _result = double.parse(_currentValue);
        } else {
          _calculateResult();
        }
        _currentValue = '';
        _operator = operator;
      }
    });
  }

  void _calculateResult() {
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
      default:
        _display = "Error";
        return;
    }
  }

  void _onEqualsPress() {
    setState(() {
      if (_currentValue.isNotEmpty && _operator.isNotEmpty) {
        if (_operator == 'sin' && _showExtendedOperators) {
          final radians = double.parse(_currentValue) * (pi / 180);
          _result = sin(radians);
        } else if (_operator == 'cos' && _showExtendedOperators) {
          final radians = double.parse(_currentValue) * (pi / 180);
          _result = cos(radians);
        } else if (_operator == 'tan' && _showExtendedOperators) {
          final radians = double.parse(_currentValue) * (pi / 180);
          _result = tan(radians);
        } else {
          _calculateResult();
        }

        _display = '$_result';
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

  void _onPoint() {
    setState(() {
      if (!_currentValue.contains('.')) {
        _currentValue += '.';
        _updateDisplay();
      }
    });
  }

  void _onDelete() {
    setState(() {
      if (_currentValue.isNotEmpty) {
        _currentValue = _currentValue.substring(0, _currentValue.length - 1);
        _updateDisplay();
      }
    });
  }

  void _toggleExtendedOperators() {
    setState(() {
      _showExtendedOperators = !_showExtendedOperators;
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _display.isNotEmpty ? _display : '$_result',
                style: const TextStyle(fontSize: 36),
              ),
            ),
            buildRow(['7', '8', '9', 'D', 'C']),
            buildRow(['4', '5', '6', '+', '-']),
            buildRow(['1', '2', '3', '*', '/']),
            buildRow(['0', '.', '=']),
            if (_showExtendedOperators) buildRow(['sin', 'cos', 'tan']),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleExtendedOperators,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons.map((text) {
        return buildButton(text);
      }).toList(),
    );
  }

  Widget buildButton(String text) {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: () {
          if (text == 'C') {
            _onClear();
          } else if (text == '=') {
            _onEqualsPress();
          } else if ('+-*/'.contains(text)) {
            _onOperatorPress(text);
          } else if (text == '.') {
            _onPoint();
          } else if (text == 'D') {
            _onDelete();
          } else if (text == 'sin' && _showExtendedOperators) {
            _operator = 'sin';
          } else if (text == 'cos' && _showExtendedOperators) {
            _operator = 'cos';
          } else if (text == 'tan' && _showExtendedOperators) {
            _operator = 'tan';
          } else {
            _onDigitPress(text);
          }
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
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