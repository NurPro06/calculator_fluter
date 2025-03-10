import 'package:calculator_fluter/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final bool isActionColor;
  final int flex;
  final Color? color;
  final Function()? onTab;

  const CalculatorButton({
    required this.text,
    this.flex = 1,
    this.isActionColor = false,
    this.color,
    this.onTab,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: onTab,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: color ?? (isActionColor ? AppColors.orange : AppColors.black),
          ),
          height: 87,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 21, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}