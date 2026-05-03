
import 'package:clone_mobile_app/screens/colors/home_color.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String hint;
  final bool obscure;
  final Widget? suffix;

  const AppTextField({
    required this.hint,
    this.obscure = false,
    this.suffix,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscure,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey[400],
        ),
        suffixIcon: widget.suffix,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: HomeColor.border,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: HomeColor.primary,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}