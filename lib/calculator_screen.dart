import 'package:calculator_fluter/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'calculator_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String screenValue = '0';
  double firstOperand = 0;
  String operation = '';
  bool isNewInput = true;

  void _inputNumber(String number) {
    setState(() {
      if (isNewInput) {
        screenValue = number;
        isNewInput = false;
      } else {
        screenValue = screenValue == '0' ? number : screenValue + number;
      }
    });
  }

  void _inputOperation(String newOperation) {
    setState(() {
      firstOperand = double.parse(screenValue);
      operation = newOperation;
      isNewInput = true;
    });
  }

  void _calculateResult() {
    setState(() {
      double secondOperand = double.parse(screenValue);
      switch (operation) {
        case '+':
          screenValue = (firstOperand + secondOperand).toString();
          break;
        case '-':
          screenValue = (firstOperand - secondOperand).toString();
          break;
        case 'X':
          screenValue = (firstOperand * secondOperand).toString();
          break;
        case '/':
          screenValue = secondOperand != 0
              ? (firstOperand / secondOperand).toString()
              : 'Error';
          break;
        default:
          return;
      }
      if (screenValue.endsWith('.0')) {
        screenValue = screenValue.substring(0, screenValue.length - 2);
      }
      isNewInput = true;
    });
  }

  void _clear() {
    setState(() {
      screenValue = '0';
      firstOperand = 0;
      operation = '';
      isNewInput = true;
    });
  }

  void _toggleSign() {
    setState(() {
      if (screenValue.startsWith('-')) {
        screenValue = screenValue.substring(1);
      } else if (screenValue != '0') {
        screenValue = '-$screenValue';
      }
    });
  }

  void _percent() {
    setState(() {
      double value = double.parse(screenValue) / 100;
      screenValue = value.toString();
      if (screenValue.endsWith('.0')) {
        screenValue = screenValue.substring(0, screenValue.length - 2);
      }
    });
  }

  void _inputDot() {
    setState(() {
      if (!screenValue.contains('.')) {
        screenValue += '.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 37),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 35),
                      child: Text(
                        screenValue,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    children: [
                      CalculatorButton(
                        text: 'C',
                        onTab: _clear,
                        color: AppColors.grey,
                      ),
                      const SizedBox(width: 10),
                      CalculatorButton(
                        text: '+/-',
                        onTab: _toggleSign,
                        color: AppColors.grey,
                      ),
                      const SizedBox(width: 10),
                      CalculatorButton(
                        text: '%',
                        onTab: _percent,
                        color: AppColors.grey,
                      ),
                      const SizedBox(width: 10),
                      CalculatorButton(
                        text: '/',
                        onTab: () => _inputOperation('/'),
                        isActionColor: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CalculatorButton(
                        text: '7',
                        onTab: () => _inputNumber('7'),
                      ),
                      const SizedBox(width: 10),
                      CalculatorButton(
                        text: '8',
                        onTab: () => _inputNumber('8'),
                      ),
                      const SizedBox(width: 10),
                      CalculatorButton(
                        text: '9',
                        onTab: () => _inputNumber('9'),
                      ),
                      const SizedBox(width: 10),
                      CalculatorButton(
                        text: 'X',
                        onTab: () => _inputOperation('X'),
                        isActionColor: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CalculatorButton(
                        text: '4',
                        onTab: () => _inputNumber('4'),
                      ),
                      const SizedBox(width: 10),
                      CalculatorButton(
                        text: '5',
                        onTab: () => _inputNumber('5'),
                      ),
                      const SizedBox(width: 10),
                      CalculatorButton(
                        text: '6',
                        onTab: () => _inputNumber('6'),
                      ),
                      const SizedBox(width: 10),
                      CalculatorButton(
                        text: '-',
                        onTab: () => _inputOperation('-'),
                        isActionColor: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CalculatorButton(
                        text: '1',
                        onTab: () => _inputNumber('1'),
                      ),
                      const SizedBox(width: 10),
                      CalculatorButton(
                        text: '2',
                        onTab: () => _inputNumber('2'),
                      ),
                      const SizedBox(width: 10),
                      CalculatorButton(
                        text: '3',
                        onTab: () => _inputNumber('3'),
                      ),
                      const SizedBox(width: 10),
                      CalculatorButton(
                        text: '+',
                        onTab: () => _inputOperation('+'),
                        isActionColor: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CalculatorButton(
                        text: '0',
                        flex: 2,
                        onTab: () => _inputNumber('0'),
                      ),
                      const SizedBox(width: 10),
                      CalculatorButton(
                        text: '.',
                        onTab: _inputDot,
                      ),
                      const SizedBox(width: 10),
                      CalculatorButton(
                        text: '=',
                        onTab: _calculateResult,
                        isActionColor: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}