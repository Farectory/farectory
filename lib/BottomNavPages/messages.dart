import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/farectory_trans_icon.png',
            color: Colors.grey,
            height: 150),
            Text('Your chats will appear here'),
          ],
        ),
      ),
    );
  }
}