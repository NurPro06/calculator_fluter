import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0'; // Отображение результата
  double _num1 = 0; // Первое число
  double _num2 = 0; // Второе число
  String _operation = ''; // Текущая операция

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '0';
        _num1 = 0;
        _num2 = 0;
        _operation = '';
      } else if ('X/+-'.contains(value)) {
        _num1 = double.parse(_display);
        _operation = value;
        _display = '0';
      } else if (value == '=') {
        _num2 = double.parse(_display);
        switch (_operation) {
          case 'X':
            _display = (_num1 * _num2).toString();
            break;
          case '/':
            _display = _num2 != 0 ? (_num1 / _num2).toString() : 'Error';
            break;
          case '+':
            _display = (_num1 + _num2).toString();
            break;
          case '-':
            _display = (_num1 - _num2).toString();
            break;
        }
        _operation = '';
      } else {
        _display = _display == '0' ? value : _display + value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2F39), // Темный фон
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: const Color(0xFF2D2F39),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 37),
        child: Column(
          children: [
            // Экран результата
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                _display,
                style: const TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            // Кнопки
            Expanded(
              child: Column(
                children: [
                  buildRow(['7', '8', '9', 'X']),
                  buildRow(['4', '5', '6', '/']),
                  buildRow(['1', '2', '3', '+']),
                  buildRow(['0', 'C', '=', '-']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(List<String> buttons) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: buttons.map((text) => buildButton(text)).toList(),
      ),
    );
  }

  Widget buildButton(String text) {
    bool isOperation = 'X/+-='.contains(text);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () => _onButtonPressed(text),
          child: Container(
            height: 77,
            decoration: BoxDecoration(
              color: const Color(0xFF3B3E4A), // Цвет кнопок
              shape: BoxShape.circle,
              boxShadow: [
                // Неоморфизм: верхняя тень
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(-4, -4),
                  blurRadius: 8,
                ),
                // Неоморфизм: нижняя тень
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  offset: const Offset(4, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 24,
                  color: isOperation ? const Color(0xFFFF9500) : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
