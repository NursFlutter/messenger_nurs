import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messenger_nurs/api/apis.dart';
import 'package:messenger_nurs/consts/color_string.dart';
import '../../main.dart';
import 'home_screen.dart';
import 'auth/login_screen.dart';

//splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      //navigate
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                APIs.auth.currentUser != null ? HomeScreen() : LoginScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    mq = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: nWhiteColor,
      //body
      body: Stack(children: [
        //app logo
        Positioned(
            top: mq.height * .15,
            right: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset('assets/images/icon.png')),

        //google login button
        Positioned(
            bottom: mq.height * .15,
            width: mq.width,
            child: const Text('EchoHub',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24, color: Colors.black87, letterSpacing: .5))),
      ]),
    );
  }
}
