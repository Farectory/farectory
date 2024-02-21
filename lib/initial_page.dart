import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:farectory/BottomNavPages/account.dart';
import 'package:farectory/BottomNavPages/homepage.dart';
import 'package:farectory/BottomNavPages/manpower.dart';
import 'package:farectory/BottomNavPages/marketplace.dart';
import 'package:farectory/BottomNavPages/messages.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  int selectedIndex = 2;
  Color color1 = Colors.black;
  Color color2 = Colors.black;
  Color color3 = Colors.black;
  Color color4 = Colors.black;
  Color color5 = Colors.black;
  final bottomNavPages = const [
    MarketPlace(),
    ManPower(),
    HomePage(),
    AccountPage(),
    Messages()
  ];

  void changeSelectedIndex(int pageNumber) {
    selectedIndex = pageNumber;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
        color3 = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.easeIn,
        height: 55,
        index: selectedIndex,
        buttonBackgroundColor: Colors.blue,
        color: Colors.white,
        backgroundColor: Colors.white24,
        items: <Widget>[
          Icon(
            Icons.shop_2_outlined,
            size: 30,
            color: color1,
          ),
          Icon(Icons.people_alt_outlined, size: 30, color: color2),
          Icon(Icons.home_outlined, size: 30, color: color3),
          Icon(Icons.person_pin_circle_outlined, size: 30, color: color4),
          Icon(Icons.message_outlined, size: 30, color: color5)
        ],
        onTap: (value) {
          changeSelectedIndex(value);
          if (value == 0) {
            setState(() {
              color1 = Colors.white;
            });
          } else{
            setState(() {
              color1 = Colors.black;
            });
          }

          if (value == 1) {
            setState(() {
              color2 = Colors.white;
            });
          } else{
            setState(() {
              color2 = Colors.black;
            });
          }

          if (value == 2) {
            setState(() {
              color3 = Colors.white;
            });
          } else{
            setState(() {
              color3 = Colors.black;
            });
          }

          if (value == 3) {
            setState(() {
              color4 = Colors.white;
            });
          } else{
            setState(() {
              color4 = Colors.black;
            });
          }

          if (value == 4) {
            setState(() {
              color5 = Colors.white;
            });
          } else{
            setState(() {
              color5 = Colors.black;
            });
          }

          if (value == 0) {
            setState(() {
              color1 = Colors.white;
            });
          } else{
            setState(() {
              color1 = Colors.black;
            });
          }
        },
      ),
      body: Center(
        child: bottomNavPages.elementAt(selectedIndex),
      ),
    );
  }
}
