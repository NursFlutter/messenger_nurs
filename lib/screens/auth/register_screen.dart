import 'package:flutter/material.dart';

import '../../consts/color_string.dart';
import '../../consts/text_string.dart';
import '../../widgets/MyButton.dart';
import '../../widgets/MyTextField.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: nWhiteColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  nRegisterWelcome,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: MyTextField(
                    hintText: nEmailAddress,
                    obscureText: false,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: MyTextField(
                    hintText: nPassword,
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: MyTextField(
                    hintText: nConfirmPassword,
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 30),
                MyButton(
                  text: nRegisterText,
                  color: nWhiteColor,
                  fontSize: 16,
                  onTap: () {}
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(nHaveAnAcc),
                    const SizedBox(width: 5),
                    GestureDetector(
                      child: Text(
                        nHaveAnAccLogin,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}