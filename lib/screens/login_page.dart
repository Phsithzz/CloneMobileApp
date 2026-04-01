import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: const Color(0xffF45B26)),
        actions: [
          Row(
            children: [
              Image.asset("assets/images/question.png", width: 30, height: 30),
              const SizedBox(width: 4),
              Image.asset("assets/images/language.jpg", width: 30, height: 30),
              const SizedBox(width: 4),

              Icon(Icons.keyboard_arrow_down, color: Colors.blueGrey[300]),
              const SizedBox(width: 4),
            ],
          ),
        ],
      ),
    );
  }
}
