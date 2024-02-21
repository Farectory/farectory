import 'package:farectory/UserPages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class WelcomeSliderScreen extends StatefulWidget {
  const WelcomeSliderScreen({super.key});

  @override
  State<WelcomeSliderScreen> createState() => _WelcomeSliderScreenState();
}

class _WelcomeSliderScreenState extends State<WelcomeSliderScreen> {
  List<ContentConfig> slides = [];

  @override
  void initState() {
    super.initState();
    slides.add(
      const ContentConfig(
        maxLineTitle: 3,
        title: "Looking to venture into agrictulture?",
        description:
            "Say no more! We have all you'll ever need to get started, scale and sky-rocket your output like never imagined",
        pathImage: "images/confused_person.png",
        backgroundColor: Colors.blue,
      ),
    );
    slides.add(
      const ContentConfig(
        colorBegin: Colors.blue,
        colorEnd: Colors.white,
        maxLineTitle: 3,
        title: "Lack capital to cultivate your land?",
        description:
            "No problemo! We can get you clients who are willing to pay you to either lease or sell your land all from the comfort of your home... In doubt? Give us a try",
        pathImage: "images/broke.png",
        backgroundColor: Colors.blue,
      ),
    );
    slides.add(const ContentConfig(
      title: "Skilled labourer or farm machine technician?",
      maxLineTitle: 3,
      description:
          "We got you covered! Whatever the nature of service you offer, we have the right client just for you",
      pathImage: "images/technician.png",
      backgroundColor: Colors.blue,
    ));
    slides.add(const ContentConfig(
      title: "Looking for genetically modified seeds for high yield and output?",
      maxLineTitle: 3,
      description:
          "You are in for the best genetically modified seeds that can be found anywhere in the world. We've got you covered",
      pathImage: "images/seed.png",
      backgroundColor: Colors.blue,
    ));
  }

  void onDonePress() {
    Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (_) => const LoginPage()),
          (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      isShowSkipBtn: false,
      prevButtonStyle: ButtonStyle(overlayColor: MaterialStateProperty.resolveWith((states) {
      // If the button is pressed, return green, otherwise blue
      if (states.contains(MaterialState.pressed)) {
        return Colors.green;
      }
      return Colors.white;
    }),
    foregroundColor: MaterialStateProperty.all(Colors.white)),
    nextButtonStyle: ButtonStyle(overlayColor: MaterialStateProperty.resolveWith((states) {
      // If the button is pressed, return green, otherwise blue
      if (states.contains(MaterialState.pressed)) {
        return Colors.green;
      }
      return Colors.white;
    }),
    foregroundColor: MaterialStateProperty.all(Colors.white)),
    doneButtonStyle: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.white)),
      listContentConfig: slides,
      onDonePress: onDonePress,
    );
  }
}
