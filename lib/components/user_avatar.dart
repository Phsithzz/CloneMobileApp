import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String image;
  final double radius;

  const UserAvatar({required this.image, this.radius = 28});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: AssetImage(image),
    );
  }
}