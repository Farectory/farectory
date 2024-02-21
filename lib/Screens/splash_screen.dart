import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:farectory/Screens/welcome_slider_screen.dart';
import 'package:farectory/initial_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Future.delayed(const Duration(seconds: 6), () {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (_) => const WelcomeSliderScreen()),
            (route) => false);
      });
    } else {
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (_) => const InitialPage()),
            (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(34, 150, 243,1),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'images/farectory_icon.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 70),
            SizedBox(
              width: 250.0,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Helvetica',
                ),
                child: AnimatedTextKit(
                  pause: const Duration(seconds: 1),
                  animatedTexts: [
                    TypewriterAnimatedText('...the farmer\'s directory',
                        textAlign: TextAlign.center,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        speed: const Duration(milliseconds: 75)),
                  ],
                ),
              ),
            )
          ],
        )));
  }
}
