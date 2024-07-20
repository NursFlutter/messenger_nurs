import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messenger_nurs/api/apis.dart';
import 'package:messenger_nurs/helper/dialogs.dart';
import 'package:messenger_nurs/screens/home_screen.dart';
import '../../consts/color_string.dart';
import '../../consts/text_string.dart';
import '../../main.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // handles google login button click
  _handleGoogleBtnCLick() {
    // for showing progress bar
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then(
      (user) async {
        // for hiding progress bar
        Navigator.pop(context);
        if (user != null) {
          log('\nUser: ${user.user}');
          log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

          if ((await APIs.userExists())) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomeScreen()));
          } else {
            await APIs.createUser().then(
              (value) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
              },
            );
          }
        }
      },
    );
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      Dialogs.showSnackBar(context, 'Something Went Wrong (Check Internet!)');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: nWhiteColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(nLoginWelcome,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontSize: 26)),
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
                const SizedBox(height: 30),
                MyButton(
                    text: nLoginText,
                    color: nWhiteColor,
                    fontSize: 16,
                    onTap: () {}),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    _handleGoogleBtnCLick();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.all(15.0),
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/google.png',
                              height: mq.height * .05),
                          const SizedBox(width: 10),
                          Text(
                            'Sign in with Google',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(nNotAMember),
                    const SizedBox(width: 5),
                    GestureDetector(
                      child: Text(
                        nNotAMemberRegister,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
