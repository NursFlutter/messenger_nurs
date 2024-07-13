import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts/color_string.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  // final TextEditingController controller;
  final FocusNode? focusNode;
  const MyTextField({super.key, required this.hintText, required this.obscureText, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
        obscureText: obscureText,
        // controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20.0),
          fillColor: nTextFieldColor,
          filled: true,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: nTextFieldColor,
            )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: nTextFieldColor
              )
          ),

        ),
    );
  }
}
