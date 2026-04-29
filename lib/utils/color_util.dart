import 'package:flutter/material.dart';

class ColorUtils {
  /// Returns black or white text color based on background luminance
  static Color contrastColor(Color background) {
    final luminance = background.computeLuminance();
    return luminance > 0.35 ? Colors.black87 : Colors.white;
  }

  /// Apply opacity for previous/next month days (50% opacity)
  static Color withMonthOpacity(Color color, bool isCurrentMonth) {
    if (isCurrentMonth) return color;
    return color.withOpacity(0.5);
  }

  /// Darken a color by percentage
  static Color darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Lighten a color
  static Color lighten(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }
}
