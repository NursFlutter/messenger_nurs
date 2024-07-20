import 'package:flutter/material.dart';

import '../consts/color_string.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final void Function()? onTap;

  const MyButton({super.key, required this.text, required this.color, required this.fontSize, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: nButtonColor, borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Text(
            text,
            style:
            Theme.of(context).textTheme.headlineMedium?.copyWith(color: color, fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
