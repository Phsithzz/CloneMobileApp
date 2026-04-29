import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String image;

  const SocialButton({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Center(
        child: SizedBox(
          width: 26,
          height: 26,
          child: Image.asset(image),
        ),
      ),
    );
  }
}