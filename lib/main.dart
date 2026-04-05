import 'package:clone_mobile_app/screens/bottom_nav_page.dart';
import 'package:clone_mobile_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Empeo App Clone",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
       home:BottomNavPage()
    );
  }
}
